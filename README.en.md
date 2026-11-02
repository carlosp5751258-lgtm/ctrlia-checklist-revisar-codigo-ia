# Before merging Claude Code's code: a review checklist (Ctrl+IA)

The Spanish version lives in the repo root and in [README.md](README.md); the English files are in `en/`.

Eight checks before merging a branch written fully or partly by Claude Code: real, unweakened tests, secrets, dependencies, licenses, scope, AI and CI configuration, an independent review and approval by a person. With a script that tells you where to look first.

Full page: https://ctrlia.dev/en/recetas/checklist-revisar-codigo-ia.html (Español: https://ctrlia.dev/recetas/checklist-revisar-codigo-ia.html)

## What's inside
| File | What for |
| --- | --- |
| `en/checklist.md` | The list to print or tick, with the why and how to check each item |
| `en/review-branch.sh` | Lists changed files, possible secrets in added lines, touched dependencies, deleted, skipped or focused tests and changes in `.claude/`, `.mcp.json`, `CLAUDE.md`, `AGENTS.md` and `.github/` |

## How to use it
Copy `en/review-branch.sh` into your project and run it from the branch you want to merge:

```bash
cp /path/to/ctrlia-checklist-revisar-codigo-ia/en/review-branch.sh .
chmod +x review-branch.sh
./review-branch.sh main        # the base branch; main by default
```
It doesn't replace human review or a secret scanner: it only looks for typical words in added lines.

## Tested
With Claude Code 2.1.316 on Linux: `bash -n`; on a branch with four planted problems (an `API_KEY`, a new `requirements.txt`, an `@unittest.skip` and a change to CLAUDE.md) it flags all of them; on a clean branch it flags nothing; it detects a deleted test; with a nonexistent base branch it exits with code 1.

## License
MIT. Copyright (c) 2026 Ctrl+IA (Carlos P.).
