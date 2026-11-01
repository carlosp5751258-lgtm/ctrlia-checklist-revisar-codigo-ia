#!/usr/bin/env bash
# Revisión rápida de una rama antes de fusionar: ./revisar-rama.sh [rama-base]
# No sustituye la revisión humana: te dice dónde mirar primero.
set -euo pipefail
base="${1:-main}"
rango="$base...HEAD"
git rev-parse --verify -q "$base" >/dev/null || { echo "No existe la rama base '$base'" >&2; exit 1; }

echo "== Archivos cambiados (¿todos tienen que ver con la tarea?)"
git diff --stat "$rango"

echo; echo "== Posibles secretos en líneas añadidas"
git diff "$rango" | grep -vE '^\+\+\+' | grep -niE '^\+.*((api|secret|private)[_-]?key|token|passw(or)?d|BEGIN [A-Z ]*PRIVATE KEY)' || echo "(nada a la vista)"

echo; echo "== Dependencias tocadas"
git diff --name-only "$rango" | grep -E '(^|/)(package(-lock)?\.json|pnpm-lock\.yaml|yarn\.lock|requirements[^/]*\.txt|pyproject\.toml|uv\.lock|poetry\.lock|go\.(mod|sum)|Cargo\.(toml|lock)|Gemfile(\.lock)?|composer\.(json|lock))$' || echo "(ninguna)"

echo; echo "== Tests borrados, saltados o enfocados"
git diff --diff-filter=D --name-only "$rango" | grep -iE 'test' || true
git diff "$rango" | grep -nE '^\+.*(@unittest\.skip|pytest\.mark\.(skip|xfail)|\b(it|describe|test)\.(skip|only)\(|\bx(it|describe)\()' || echo "(ninguno añadido)"

echo; echo "== Configuración de la IA y del CI tocada"
git diff --name-only "$rango" | grep -E '^(\.claude/|\.mcp\.json|CLAUDE\.md|AGENTS\.md|\.github/)' || echo "(nada)"
