#!/usr/bin/env bash
set -euo pipefail

echo "=== STEP 8: ADD YANDEX METRIKA ==="
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
echo "OK: backup ready"
echo

LAYOUT="src/layouts/Layout.astro"
cp -a "$LAYOUT" "$LAYOUT.bak.$TS"

python3 - <<'PY'
from pathlib import Path

p = Path("src/layouts/Layout.astro")
s = p.read_text(encoding="utf-8")

# 1. META verification — в <head>
meta = '<meta name="yandex-verification" content="c46ddda0bad99ceb" />'

if meta not in s:
    if "</head>" not in s:
        raise SystemExit("ERROR: </head> not found in Layout.astro")
    s = s.replace("</head>", f"  {meta}\n</head>")
    print("OK: yandex-verification meta added")
else:
    print("OK: yandex-verification meta already exists")

# 2. Script + noscript
script_block = '''
<!-- Yandex.Metrika counter -->
<script type="text/javascript">
(function(m,e,t,r,i,k,a){
m[i]=m[i]||function(){(m[i].a=m[i].a||[]).push(arguments)};
m[i].l=1*new Date();
for (var j = 0; j < document.scripts.length; j++) {if (document.scripts[j].src === r) { return; }}
k=e.createElement(t),a=e.getElementsByTagName(t)[0],k.async=1,k.src=r,a.parentNode.insertBefore(k,a)
})(window, document,'script','https://mc.yandex.ru/metrika/tag.js?id=106270495', 'ym');

ym(106270495, 'init', {ssr:true, webvisor:true, clickmap:true, ecommerce:"dataLayer", accurateTrackBounce:true, trackLinks:true});
</script>
<noscript>
  <div>
    <img src="https://mc.yandex.ru/watch/106270495" style="position:absolute; left:-9999px;" alt="" />
  </div>
</noscript>
<!-- /Yandex.Metrika counter -->
'''

if "mc.yandex.ru/metrika/tag.js?id=106270495" not in s:
    if "</body>" not in s:
        raise SystemExit("ERROR: </body> not found in Layout.astro")
    s = s.replace("</body>", script_block + "\n</body>")
    print("OK: Yandex Metrika script added")
else:
    print("OK: Yandex Metrika script already exists")

p.write_text(s, encoding="utf-8")
PY

echo
echo "=== CHECK: show Layout.astro head/body fragments ==="
python3 - <<'PY'
from pathlib import Path
s = Path("src/layouts/Layout.astro").read_text(encoding="utf-8")

print("---- HEAD ----")
h = s[s.find("<head"):s.find("</head>")+7]
print(h)

print("\n---- BODY END ----")
b = s[s.rfind("</script>")-400:s.rfind("</body>")+7]
print(b)
PY

echo
echo "=== DONE STEP 8 ==="
echo "Backup: $BKDIR/repo.tar.gz"
