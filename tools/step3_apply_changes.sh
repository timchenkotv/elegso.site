#!/usr/bin/env bash
set -euo pipefail

echo "=== STEP 3: APPLY CHANGES (index + footer) ==="
cd "$(dirname "$0")/.."

TS=$(date "+%Y-%m-%d_%H%M%S")
BKDIR=".backup/$TS"
mkdir -p "$BKDIR"

echo "=== BACKUP BEFORE EDIT -> $BKDIR/repo.tar.gz ==="
tar -czf "$BKDIR/repo.tar.gz" \
  --exclude="./node_modules" \
  --exclude="./dist" \
  --exclude="./.backup" \
  .
gzip -t "$BKDIR/repo.tar.gz"
echo "OK: backup ready: $BKDIR/repo.tar.gz"
echo

# 1) index.astro
FILE="src/pages/index.astro"
cp -a "$FILE" "$FILE.bak.$TS"

python3 - <<'PY'
from pathlib import Path
import re

p = Path("src/pages/index.astro")
s = p.read_text(encoding="utf-8")

# (1) убрать "Внутренние ссылки — относительные."
needle = " Внутренние ссылки — относительные."
if needle not in s:
    raise SystemExit("ERROR: phrase not found in index.astro: " + needle)
s = s.replace(needle, "")

# (2) удалить блок <details class="where">...</details>
m = re.search(r'<details\s+class="where"[\s\S]*?</details>', s)
if not m:
    raise SystemExit('ERROR: <details class="where"> block not found in index.astro')
s = s[:m.start()] + s[m.end():]

p.write_text(s, encoding="utf-8")
print("OK: index.astro updated")
PY

# 2) FooterNative.astro
FOOT="src/components/FooterNative.astro"
cp -a "$FOOT" "$FOOT.bak.$TS"

python3 - <<'PY'
from pathlib import Path

p = Path("src/components/FooterNative.astro")
s = p.read_text(encoding="utf-8")

# (1) Заголовок "ГЛОБАЛЬНАЯ ЦЕЛЬ КОМПАНИИ" или "ГЛОБАЛЬНАЯ ЦЕЛЬ" -> "Глобальная цель"
if "ГЛОБАЛЬНАЯ ЦЕЛЬ КОМПАНИИ" in s:
    s = s.replace("ГЛОБАЛЬНАЯ ЦЕЛЬ КОМПАНИИ", "Глобальная цель")
elif "ГЛОБАЛЬНАЯ ЦЕЛЬ" in s:
    s = s.replace("ГЛОБАЛЬНАЯ ЦЕЛЬ", "Глобальная цель")
else:
    raise SystemExit("ERROR: did not find global goal header in FooterNative.astro")

# (2) удаляем старую ссылку "Москва — работаем по всей России"
s = s.replace('<a href="#" data-astro-cid-sz7xmlte="">Москва — работаем по всей России</a>', '')

# (3) вставляем 2 раскрывашки в контакты (после mail@elegso.ru)
needle = '<a href="mailto:mail@elegso.ru" data-astro-cid-sz7xmlte="">mail@elegso.ru</a>'
if needle not in s:
    raise SystemExit("ERROR: mail link needle not found in FooterNative.astro")

manifest_details = (
    '<details class="tab" data-astro-cid-sz7xmlte="">'
    ' <summary class="tab-sum" data-astro-cid-sz7xmlte="">'
    ' <span class="tab-h" data-astro-cid-sz7xmlte="">НАШ МАНИФЕСТ</span>'
    ' <span class="tab-chev" aria-hidden="true" data-astro-cid-sz7xmlte=""></span>'
    ' </summary>'
    ' <div class="tab-body" data-astro-cid-sz7xmlte="">'
    ' <div class="tab-t" data-astro-cid-sz7xmlte="">'
    '«Мы считаем, что сила — в правде. Интеллект — наше оружие. И если этого будет мало — мы злее!»'
    '</div>'
    ' </div>'
    '</details>'
)

moscow_details = (
    '<details class="tab" data-astro-cid-sz7xmlte="">'
    ' <summary class="tab-sum" data-astro-cid-sz7xmlte="">'
    ' <span class="tab-h" data-astro-cid-sz7xmlte="">Москва — работаем по всей России</span>'
    ' <span class="tab-chev" aria-hidden="true" data-astro-cid-sz7xmlte=""></span>'
    ' </summary>'
    ' <div class="tab-body" data-astro-cid-sz7xmlte="">'
    ' <div class="tab-t" data-astro-cid-sz7xmlte="">'
    'Мы базируемся в Москве, но ведём арбитражные споры по всей России. '
    'Суды оснащены ВКС и системами онлайн-заседаний, поэтому участие в процессах возможно дистанционно, '
    'когда вы находитесь за пределами Москвы и Московской области. '
    'Если онлайн-формат невозможен — выезжаем в командировку в любой регион России без проблем.'
    '</div>'
    ' </div>'
    '</details>'
)

s = s.replace(needle, needle + " " + manifest_details + " " + moscow_details)

p.write_text(s, encoding="utf-8")
print("OK: FooterNative.astro updated")
PY

echo
echo "=== QUICK CHECK SNIPPETS ==="
echo "--- index.astro: show contacts block around header"
python3 - <<'PY'
from pathlib import Path
s = Path("src/pages/index.astro").read_text(encoding="utf-8").splitlines()
for i,line in enumerate(s,1):
    if "Запросить разбор судебного спора" in line:
        for j in range(max(1,i-2), min(len(s), i+28)+1):
            print(f"{j:5d} {s[j-1]}")
        break
PY

echo
echo "--- FooterNative.astro: show lines containing 'Глобальная цель' / 'НАШ МАНИФЕСТ' / 'Москва — работаем'"
python3 - <<'PY'
from pathlib import Path
s = Path("src/components/FooterNative.astro").read_text(encoding="utf-8").splitlines()
keys=["Глобальная цель","НАШ МАНИФЕСТ","Москва — работаем"]
for k in keys:
    print("##",k)
    hits=0
    for i,line in enumerate(s,1):
        if k in line:
            hits += 1
            for j in range(max(1,i-2), min(len(s), i+10)+1):
                print(f"{j:5d} {s[j-1]}")
            break
    if hits==0:
        print("  NOT FOUND")
    print()
PY

echo "=== DONE STEP 3 ==="
echo "Backup: $BKDIR/repo.tar.gz"
