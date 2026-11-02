# Antes de fusionar código de Claude Code: checklist de revisión (Ctrl+IA)

English version: [README.en.md](README.en.md) (archivos en `en/`).

Ocho comprobaciones antes de fusionar una rama escrita en todo o en parte por Claude Code: tests reales y no debilitados, secretos, dependencias, licencias, alcance, configuración de la IA y del CI, una revisión independiente y la aprobación de una persona. Con un script que te dice dónde mirar primero.

Página completa: https://ctrlia.dev/recetas/checklist-revisar-codigo-ia.html (English: https://ctrlia.dev/en/recetas/checklist-revisar-codigo-ia.html)

## Qué trae
| Archivo | Para qué |
| --- | --- |
| `checklist.md` / `en/checklist.md` | La lista para imprimir o marcar, con el porqué y cómo comprobar cada punto |
| `revisar-rama.sh` | Lista archivos cambiados, posibles secretos en líneas añadidas, dependencias tocadas, tests borrados, saltados o enfocados y cambios en `.claude/`, `.mcp.json`, `CLAUDE.md`, `AGENTS.md` y `.github/` |

## Cómo usarlo
Desde la rama que quieres fusionar:

```bash
chmod +x revisar-rama.sh
./revisar-rama.sh main        # la rama base; por defecto main
```
No sustituye la revisión humana ni un escáner de secretos: solo busca palabras típicas en las líneas añadidas.

## Probado
Con Claude Code 2.1.316 en Linux: `bash -n`; sobre una rama con cuatro fallos sembrados (una `API_KEY`, un `requirements.txt` nuevo, un `@unittest.skip` y un cambio en CLAUDE.md) los señala todos; en una rama limpia no señala nada; detecta un test borrado; con una rama base inexistente sale con código 1.

## Licencia
MIT. Copyright (c) 2026 Ctrl+IA (Carlos P.).
