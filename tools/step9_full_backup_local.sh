#!/usr/bin/env bash
set -euo pipefail

echo "=== STEP 9: FULL BACKUP (repo + node_modules + dist) ==="
cd "$(dirname "$0")/.."

TS=$(date "+%Y-%m-%d_%H%M%S")
BKDIR=".backup/full-$TS"
mkdir -p "$BKDIR"

echo "PWD: $(pwd)"
echo "Backup dir: $BKDIR"
echo

echo "=== QUICK STATUS ==="
git rev-parse --short HEAD 2>/dev/null || echo "NO GIT"
git status --porcelain 2>/dev/null || true
echo

echo "=== SIZES (for awareness) ==="
du -sh . 2>/dev/null || true
du -sh node_modules 2>/dev/null || echo "node_modules: (missing)"
du -sh dist 2>/dev/null || echo "dist: (missing)"
echo

ARCH="$BKDIR/elegso.site-full-$TS.tar.gz"

echo "=== CREATE ARCHIVE: $ARCH ==="
# самый полный бэкап: всё содержимое репо, включая node_modules, dist, .git и т.д.
# исключаем только саму папку .backup, чтобы не архивировать архивы.
tar -czf "$ARCH" --exclude="./.backup" .

echo "=== VERIFY ARCHIVE (gzip -t) ==="
gzip -t "$ARCH"
echo "OK: gzip test passed"
echo

echo "=== WRITE MANIFEST ==="
{
  echo "timestamp: $TS"
  echo "pwd: $(pwd)"
  echo -n "git_head: "
  git rev-parse --short HEAD 2>/dev/null || echo "no-git"
  echo "archive: $ARCH"
  echo -n "archive_size: "
  ls -lh "$ARCH" | awk "{print \$5}"
  echo -n "archive_sha256: "
  shasum -a 256 "$ARCH" | awk "{print \$1}"
} > "$BKDIR/manifest.txt"

echo "OK: manifest saved: $BKDIR/manifest.txt"
echo
echo "=== DONE STEP 9 ==="
echo "Backup file: $ARCH"
