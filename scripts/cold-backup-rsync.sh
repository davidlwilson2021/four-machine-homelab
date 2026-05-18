#!/usr/bin/env bash
# Weekly cold backup: Antsle -> WD My Cloud (power WD on before run, off after).
# Run from TrueNAS shell or scheduled task. Edit variables below.

set -euo pipefail

WD_HOST="${WD_HOST:-[REDACTED_HOSTNAME]}"
WD_SHARE="${WD_SHARE:-coldbackup}"
WD_USER="${WD_USER:-backup_user}"
SOURCE="${SOURCE:-/mnt/tank/documents}"
MOUNT="${MOUNT:-/mnt/wd-cold}"
LOG="${LOG:-/var/log/cold-backup.log}"

log() { echo "$(date -Iseconds) $*" | tee -a "$LOG"; }

log "Mounting WD share (ensure WD is powered on)"
mkdir -p "$MOUNT"
mount -t cifs "//${WD_HOST}/${WD_SHARE}" "$MOUNT" \
  -o "username=${WD_USER},vers=2.0" || { log "Mount failed"; exit 1; }

log "Starting rsync from ${SOURCE}"
rsync -avh --delete --stats "${SOURCE}/" "${MOUNT}/" | tee -a "$LOG"

log "Unmounting WD"
umount "$MOUNT"
log "Cold backup complete — power off WD My Cloud"
