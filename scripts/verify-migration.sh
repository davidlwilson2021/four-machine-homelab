#!/usr/bin/env bash
# Post-migration verification (Antsle manual §10.4).
# Compare file counts and sizes between WD mount and tank/documents.

set -euo pipefail

WD_PATH="${1:-/mnt/wd-migration}"
TANK_PATH="${2:-/mnt/tank/documents}"

echo "=== File counts ==="
WD_COUNT=$(find "$WD_PATH" -type f | wc -l)
TANK_COUNT=$(find "$TANK_PATH" -type f | wc -l)
echo "WD:   $WD_COUNT"
echo "Tank: $TANK_COUNT"
if [[ "$WD_COUNT" -ne "$TANK_COUNT" ]]; then
  echo "WARNING: file counts differ"
  exit 1
fi

echo "=== Sizes ==="
du -sh "$WD_PATH" "$TANK_PATH"

echo "=== Optional deep diff (set FOLDER=important-folder) ==="
if [[ -n "${FOLDER:-}" ]]; then
  if ! diff -rq "$WD_PATH/$FOLDER" "$TANK_PATH/$FOLDER"; then
    echo "ERROR: differences found in $FOLDER — migration may be incomplete"
    exit 1
  fi
fi

echo "OK: counts match"
