#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.." || exit 1

python3 -c 'from pathlib import Path
text = """# ELEGSO.site (Astro)

Статический сайт ELEGSO на Astro (output: static).
Рабочий цикл: правка → npm run build → dist готов к деплою.

## Быстрый старт
- npm install
- npm run dev -- --host 127.0.0.1 --port 4321
- npm run build

## Где что лежит
Страницы:
- Главная: src/pages/index.astro
- Кейсы (список): src/pages/cases/index.astro
- Кейс (детально): src/pages/cases/[slug].astro

Компоненты:
- Команда: src/components/TeamNative.astro

Стили:
- src/styles/global.css (точка входа)
- src/styles/legacy.css (текущие стили, импортируются из global.css)

Статика:
- public/images/team/*.png  → на сайте: /images/team/...

Сборка:
- dist/ (готовый статический сайт)

## Правила (чтобы не ломать)
- После любых правок: npm run build должен быть OK.
- Картинки/ссылки на статику в коде: использовать root-relative пути вида /images/...
  Это НЕ привязано к домену и не сломается при смене домена.
  (Если когда-то будем хостить сайт в подпапке, тогда настроим base в Astro.)

## “Промпт для ИИ” перед правкой
Цель правки: …
Где править: src/pages/… / src/components/… / src/styles/… / public/…
Ограничения: не трогать лишнее, сохранить стиль, npm run build обязателен.
"""
Path("README.md").write_text(text, encoding="utf-8")
print("OK: README.md regenerated")'

