#!/usr/bin/env bash
# Quick review of a branch before merging: ./review-branch.sh [base-branch]
# It doesn't replace human review: it tells you where to look first.
set -euo pipefail
base="${1:-main}"
range="$base...HEAD"
git rev-parse --verify -q "$base" >/dev/null || { echo "Base branch '$base' does not exist" >&2; exit 1; }

echo "== Changed files (are they all related to the task?)"
git diff --stat "$range"

echo; echo "== Possible secrets in added lines"
git diff "$range" | grep -vE '^\+\+\+' | grep -niE '^\+.*((api|secret|private)[_-]?key|token|passw(or)?d|BEGIN [A-Z ]*PRIVATE KEY)' || echo "(nothing in sight)"

echo; echo "== Dependencies touched"
git diff --name-only "$range" | grep -E '(^|/)(package(-lock)?\.json|pnpm-lock\.yaml|yarn\.lock|requirements[^/]*\.txt|pyproject\.toml|uv\.lock|poetry\.lock|go\.(mod|sum)|Cargo\.(toml|lock)|Gemfile(\.lock)?|composer\.(json|lock))$' || echo "(none)"

echo; echo "== Tests deleted, skipped or focused"
git diff --diff-filter=D --name-only "$range" | grep -iE 'test' || true
git diff "$range" | grep -nE '^\+.*(@unittest\.skip|pytest\.mark\.(skip|xfail)|\b(it|describe|test)\.(skip|only)\(|\bx(it|describe)\()' || echo "(none added)"

echo; echo "== AI and CI configuration touched"
git diff --name-only "$range" | grep -E '^(\.claude/|\.mcp\.json|CLAUDE\.md|AGENTS\.md|\.github/)' || echo "(nothing)"
