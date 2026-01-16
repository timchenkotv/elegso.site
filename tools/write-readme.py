# ELEGSO.site (Astro)

Статический сайт юридической компании **ELEGSO** на **Astro** (режим `output: "static"`).
Цель: быстрые правки → `npm run build` → готовый статический `dist/`.

## Быстрый старт (Mac/Linux)

Установка зависимостей:
- npm install

Запуск локально:
- npm run dev -- --host 127.0.0.1 --port 4321

Сборка (обязательно перед деплоем):
- npm run build

## Карта проекта (где что лежит)

Страницы:
- Главная: src/pages/index.astro
- Кейсы (список): src/pages/cases/index.astro
- Кейс (детально): src/pages/cases/[slug].astro (есть getStaticPaths)

Компоненты:
- Команда: src/components/TeamNative.astro

Стили:
- src/styles/global.css — точка входа
- src/styles/legacy.css — текущие “унаследованные” стили (импортируется из global.css)

Статика (копируется как есть):
- public/images/team/*.png  → доступно на сайте как /images/team/...

Результат сборки:
- dist/index.html
- dist/_astro/*.css
- dist/images/team/*.png
- dist/cases/...

## Правила правок (чтобы не ломать сайт)

Перед каждым изменением:
1) Запусти локально:
   npm run dev -- --host 127.0.0.1 --port 4321
2) Внеси правки в src/... или public/...
3) Собери:
   npm run build
4) Проверь, что в dist/ есть:
   - dist/index.html
   - dist/_astro/*.css
   - dist/images/team/*.png
   - dist/cases/...

## “Промпт для ИИ” перед правками (вставляй в чат)

- Цель правки: (что меняем)
- Где править:
  - страница: src/pages/...
  - компонент: src/components/...
  - стили: src/styles/...
  - картинки/статика: public/...
- Ограничения:
  - не трогать лишние файлы
  - сохранить текущий стиль/структуру
  - после правки обязательно npm run build должен быть OK
- Пути к картинкам использовать как /images/... (root-relative)

Пояснение про /images/...:
- Это НЕ привязано к домену (домен можно менять — ок).
- Но если сайт будут хостить в подпапке (example.com/elegso/), тогда нужно будет настраивать base в Astro.
