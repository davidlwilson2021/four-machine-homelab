#!/usr/bin/env bash
# Weekly cold backup: Antsle -> offline backup NAS (power NAS on before run, off after).
# Run from TrueNAS shell or scheduled task. Edit variables below.

set -euo pipefail

WD_HOST="${WD_HOST:-[REDACTED_HOSTNAME]}"
WD_SHARE="${WD_SHARE:-coldbackup}"
WD_USER="${WD_USER:-backup_user}"
WD_PASS="${WD_PASS:-}"
SOURCE="${SOURCE:-/mnt/tank/documents}"
MOUNT="${MOUNT:-/mnt/wd-cold}"
LOG="${LOG:-/var/log/cold-backup.log}"
SMB_OPTS="${SMB_OPTS:-vers=3.1.1,seal}"

log() { echo "$(date -Iseconds) $*" | tee -a "$LOG"; }

if [[ -z "$WD_PASS" ]]; then
  log "WD_PASS is empty; export WD_PASS before running for non-interactive mount auth"
  exit 1
fi

log "Mounting backup share (ensure NAS is powered on)"
mkdir -p "$MOUNT"
mount -t cifs "//${WD_HOST}/${WD_SHARE}" "$MOUNT" \
  -o "username=${WD_USER},password=${WD_PASS},${SMB_OPTS}" || { log "Mount failed"; exit 1; }

log "Starting rsync from ${SOURCE}"
rsync -avh --delete --stats "${SOURCE}/" "${MOUNT}/" | tee -a "$LOG"

log "Unmounting WD"
umount "$MOUNT"
log "Cold backup complete — power off backup NAS"
