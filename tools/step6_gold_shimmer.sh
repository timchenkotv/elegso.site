#!/usr/bin/env bash
set -euo pipefail

echo "=== STEP 6: GOLD SHIMMER IN HERO CARD ==="
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

HERO="src/components/HeroNative.astro"
CSS="src/styles/legacy.css"

cp -a "$HERO" "$HERO.bak.$TS"
cp -a "$CSS"  "$CSS.bak.$TS"

echo "=== PATCH: replace footnote with gold shimmer bar ==="

python3 - <<'PY'
from pathlib import Path

hero = Path("src/components/HeroNative.astro")
s = hero.read_text(encoding="utf-8")

old = '<p class="fine" data-astro-cid-bbe6dxrz="">*Текст и цифры — примеры. Заменим на ваши реальные данные.</p>'
if old not in s:
    raise SystemExit("ERROR: target footnote not found in HeroNative.astro (exact match)")

# Вставляем премиальный декоративный элемент вместо текста
new = '<div class="lux-goldbar" aria-hidden="true" data-astro-cid-bbe6dxrz=""></div>'
s = s.replace(old, new)

hero.write_text(s, encoding="utf-8")
print("OK: HeroNative.astro updated")
PY

echo "=== PATCH: add CSS for .lux-goldbar (premium shimmer) ==="

python3 - <<'PY'
from pathlib import Path

css = Path("src/styles/legacy.css")
s = css.read_text(encoding="utf-8")

marker = "/* LUX GOLD BAR */"
if marker in s:
    print("OK: marker already present, skipping CSS append")
else:
    add = r'''

/* LUX GOLD BAR */
.lux-goldbar{
  margin-top: 12px;
  height: 10px;
  border-radius: 999px;
  background:
    linear-gradient(110deg,
      rgba(255,215,128,0.12) 0%,
      rgba(255,215,128,0.28) 18%,
      rgba(255,245,205,0.65) 30%,
      rgba(255,215,128,0.30) 45%,
      rgba(255,215,128,0.12) 60%,
      rgba(255,215,128,0.18) 100%);
  box-shadow:
    0 0 0 1px rgba(255,215,128,0.18) inset,
    0 8px 22px rgba(0,0,0,0.28);
  position: relative;
  overflow: hidden;
}

/* мягкое "переливание" без дешёвого блеска */
.lux-goldbar::before{
  content:"";
  position:absolute;
  inset:-40% -60%;
  background:
    linear-gradient(110deg,
      rgba(255,255,255,0.00) 0%,
      rgba(255,255,255,0.08) 35%,
      rgba(255,255,255,0.22) 50%,
      rgba(255,255,255,0.08) 65%,
      rgba(255,255,255,0.00) 100%);
  transform: translateX(-30%) rotate(8deg);
  animation: luxShimmer 5.2s ease-in-out infinite;
  mix-blend-mode: screen;
}

@keyframes luxShimmer{
  0%   { transform: translateX(-35%) rotate(8deg); opacity: .35; }
  35%  { opacity: .55; }
  55%  { opacity: .70; }
  100% { transform: translateX(35%) rotate(8deg); opacity: .40; }
}

@media (prefers-reduced-motion: reduce){
  .lux-goldbar::before{ animation: none; }
}
'''
    css.write_text(s + add, encoding="utf-8")
    print("OK: legacy.css appended with lux-goldbar styles")
PY

echo
echo "=== SHOW CHECK: HeroNative snippet around lux-goldbar ==="
python3 - <<'PY'
from pathlib import Path
s = Path("src/components/HeroNative.astro").read_text(encoding="utf-8")
i = s.find("lux-goldbar")
if i < 0:
    raise SystemExit("ERROR: lux-goldbar not found after edit")
start = max(0, i-220)
end   = min(len(s), i+220)
print(s[start:end])
PY

echo
echo "=== DONE STEP 6 ==="
echo "Backup: $BKDIR/repo.tar.gz"
