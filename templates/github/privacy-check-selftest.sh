#!/usr/bin/env bash
# Regression tests for .github/workflows/privacy.yml. Runs the workflow's own step
# scripts against throwaway repositories with synthetic data (no real personal data).
# Usage: templates/github/privacy-check-selftest.sh [path/to/repo] [path/to/gitleaks]
# The repo (default: this one) supplies the workflow, its .gitleaks.toml if any, and
# optional repo-specific gitleaks cases in .github/privacy-selftest-cases, one per line:
#   <0 to pass | 1 to fail>|<path>|<line>   ({UUID} becomes a synthetic UUID and {Q} a
#   double quote, so the cases file itself does not look like a secret)
# Needs git 2.36+, python3 with PyYAML, and optionally gitleaks for the secret cases.
set -u
ROOT=$(cd "${1:-$(dirname "$0")/../..}" && pwd)
GITLEAKS=${2:-$(command -v gitleaks || true)}
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT
CONFIG=()
[ -f "$ROOT/.gitleaks.toml" ] && { cp "$ROOT/.gitleaks.toml" "$WORK/gitleaks.toml"; CONFIG=(--config "$WORK/gitleaks.toml"); }

python3 - "$ROOT/.github/workflows/privacy.yml" "$WORK" <<'EOF'
import sys, yaml
w = yaml.safe_load(open(sys.argv[1]))
with open(sys.argv[2] + "/env.sh", "w") as f:
    for k, v in w["env"].items():
        f.write("export %s='%s'\n" % (k, v))
for i, s in enumerate(w["jobs"]["privacy"]["steps"][1:]):
    open("%s/step%d.sh" % (sys.argv[2], i), "w").write(s["run"])
EOF
. "$WORK/env.sh"

OK=(-c user.email=1+test@users.noreply.github.com -c user.name=test)
# Synthetic values are assembled at run time so this file itself passes the privacy check.
DOMAIN=mail.test.org; EMAIL="jane.doe@$DOMAIN"
TOKEN="ghp_$(printf 'a1B2c3D4e5%.0s' 1 2 3 4)"; TOKEN=${TOKEN:0:40}
UUID=7cd5dca8-857f-49e5-8fd5-16a03658b0b7
fails=0
new_repo() { rm -rf "$WORK/r"; mkdir "$WORK/r"; cd "$WORK/r"; git init -q; git "${OK[@]}" commit -q --allow-empty -m base; }
# expect <name> <step> <0|1> [text that must not appear in the output]
expect() {
  export BASE HEAD RUNNER_TEMP
  BASE=$(git rev-list --max-parents=0 HEAD); HEAD=$(git rev-parse HEAD); RUNNER_TEMP=$(mktemp -d -p "$WORK")
  if [ "$2" = 2 ]; then
    [ -n "$GITLEAKS" ] || { echo "skip  $1 (no gitleaks)"; return; }
    out=$("$GITLEAKS" git . "${CONFIG[@]}" --log-opts="$BASE..$HEAD" --redact --no-banner 2>&1); rc=$?
  else
    out=$(bash -e "$WORK/step$2.sh" 2>&1); rc=$?
  fi
  [ "$rc" -ne 0 ] && rc=1
  if [ "$rc" = "$3" ] && { [ -z "${4:-}" ] || ! grep -qF "$4" <<<"$out"; }; then echo "pass  $1"
  else echo "FAIL  $1 (exit $rc, expected $3)"; echo "$out" | sed 's/^/      /'; fails=$((fails + 1)); fi
}

new_repo; echo 'see name@example.com, noreply@anthropic.com' > a.md; mkdir x; echo "\"a@$DOMAIN\"" > x/package-lock.json
git add -A; git "${OK[@]}" commit -qm ok -m "Co-Authored-By: A <noreply@anthropic.com>"
expect "placeholders and noreply addresses pass" 1 0

new_repo; echo y > a.txt; git add -A; git -c user.email=$EMAIL -c user.name=j commit -qm c
expect "personal commit email fails, address not printed" 0 1 "jane.doe"

new_repo; echo "contact $EMAIL" > a.txt; git add -A; git "${OK[@]}" commit -qm add
git rm -q a.txt; git "${OK[@]}" commit -qm del
expect "email added then deleted fails" 1 1 "jane.doe"

new_repo; echo "contact $EMAIL" > a.txt; git add -A; git "${OK[@]}" commit -qm add
echo 'contact name@example.com' > a.txt; git "${OK[@]}" commit -qam replace
expect "email added then replaced fails" 1 1 "jane.doe"

new_repo; echo x > "$EMAIL.txt"; git add -A; git "${OK[@]}" commit -qm f
expect "email in a file name fails, name not printed" 1 1 "jane.doe"

new_repo; : > "$EMAIL.txt"; git add -A; git "${OK[@]}" commit -qm f
expect "email in an empty file's name fails" 1 1 "jane.doe"

new_repo; printf '\0\1' > "$EMAIL.bin"; git add -A; git "${OK[@]}" commit -qm f
expect "email in a binary file's name fails" 1 1 "jane.doe"

new_repo; echo x > a.txt; git add -A; git "${OK[@]}" commit -qm a; git mv a.txt "$EMAIL.txt"; git "${OK[@]}" commit -qm mv
expect "email in a renamed file's name fails" 1 1 "jane.doe"

new_repo; echo x > b.txt; git add -A; git "${OK[@]}" commit -qm x -m "Co-authored-by: J <$EMAIL>"
expect "email in a commit message fails" 1 1 "jane.doe"

new_repo; echo x > b.txt; git add -A
git "${OK[@]}" commit -qm "$(printf 'x\n@@commit %s\n%s' "$EMAIL" "$EMAIL")"
expect "commit message posing as parser input fails" 1 1 "jane.doe"

new_repo; echo x > b.txt; git add -A
git "${OK[@]}" commit -qm "$(printf 'x\n@@commit %s\n@@message\n%s' "$EMAIL" "$EMAIL")"
expect "commit message posing as a commit id is not printed" 1 1 "jane.doe"

new_repo; printf 'x\n++ b/package-lock.json\n%s\n' "$EMAIL" > a.txt; git add -A; git "${OK[@]}" commit -qm f
expect "added line posing as a file header fails" 1 1 "jane.doe"

new_repo; git checkout -qb side; echo s > s.txt; git add -A; git "${OK[@]}" commit -qm side
git checkout -q -; echo m > m.txt; git add -A; git "${OK[@]}" commit -qm main
git "${OK[@]}" merge -q --no-commit side >/dev/null 2>&1; echo "contact $EMAIL" > evil.txt; git add -A; git "${OK[@]}" commit -qm merge
expect "email added only by a merge commit fails" 1 1 "jane.doe"

new_repo; b0=$(git rev-parse HEAD)
for b in s1 s2 top; do git checkout -qb $b "$b0"; echo $b > $b.txt; git add -A; git "${OK[@]}" commit -qm $b; done
git "${OK[@]}" merge -q --no-commit s1 s2 >/dev/null 2>&1; echo "contact $EMAIL" > evil.txt; git add -A; git "${OK[@]}" commit -qm octopus
[ "$(git rev-list --parents -n 1 HEAD | wc -w)" = 4 ] || echo "FAIL  octopus fixture has the wrong parent count"
expect "merge with three parents is refused" 1 1 "jane.doe"

new_repo; printf 'GITHUB_TOKEN=%s\n' "$TOKEN" > c.env; git add -A; git "${OK[@]}" commit -qm s
expect "secret fails, value redacted" 2 1 "$TOKEN"

new_repo; printf 'api_key = "%s"\n' "$UUID" > config.txt; git add -A; git "${OK[@]}" commit -qm u
expect "UUID-shaped secret fails" 2 1

# Repository-specific gitleaks exceptions: each listed line must pass or fail as stated.
if [ -f "$ROOT/.github/privacy-selftest-cases" ]; then
  while IFS='|' read -r want path line; do
    case "$want" in 0|1) ;; *) continue ;; esac
    new_repo; mkdir -p "$(dirname "$path")"; line=${line//\{UUID\}/$UUID}; printf '%s\n' "${line//\{Q\}/\"}" > "$path"
    git add -A; git "${OK[@]}" commit -qm case
    expect "repo case: $path line $( [ "$want" = 0 ] && echo passes || echo fails )" 2 "$want" "$UUID"
  done < "$ROOT/.github/privacy-selftest-cases"
fi

echo; [ "$fails" = 0 ] && echo "All privacy-check tests passed." || { echo "$fails test(s) failed."; exit 1; }
