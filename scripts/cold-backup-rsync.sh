#!/usr/bin/env bash
# Weekly cold backup: Antsle -> offline backup NAS (power NAS on before run, off after).
# Run from TrueNAS shell or scheduled task. Edit variables below.
#
# Auth: prefer WD_CREDENTIALS_FILE (mode 600, not in git). WD_PASS is supported only
# by writing a temporary credentials file — never passed on the mount command line.
#
# rsync --delete is opt-in: set RSYNC_DELETE=1 and CONFIRM_DELETE=yes after validating paths.
# Use --dry-run to preview without writing.

set -euo pipefail

WD_HOST="${WD_HOST:-[REDACTED_HOSTNAME]}"
WD_SHARE="${WD_SHARE:-coldbackup}"
WD_USER="${WD_USER:-backup_user}"
WD_PASS="${WD_PASS:-}"
WD_CREDENTIALS_FILE="${WD_CREDENTIALS_FILE:-}"
SOURCE="${SOURCE:-/mnt/tank/documents}"
MOUNT="${MOUNT:-/mnt/wd-cold}"
LOG="${LOG:-/var/log/cold-backup.log}"
SMB_OPTS="${SMB_OPTS:-vers=3.1.1,seal}"
DRY_RUN=false
TEMP_CRED_FILE=""

usage() {
  cat <<'EOF'
Usage: cold-backup-rsync.sh [--dry-run]

  --dry-run    Mount and run rsync with --dry-run (no writes to backup target).

Environment:
  WD_CREDENTIALS_FILE   SMB credentials file (username= / password= lines). Preferred.
  WD_PASS               If set and WD_CREDENTIALS_FILE empty, writes a temp creds file.
  RSYNC_DELETE=1        Enable rsync --delete (destructive on target).
  CONFIRM_DELETE=yes    Required together with RSYNC_DELETE=1.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 1 ;;
  esac
done

log() { echo "$(date -Iseconds) $*" | tee -a "$LOG"; }

cleanup() {
  if [[ -n "$TEMP_CRED_FILE" && -f "$TEMP_CRED_FILE" ]]; then
    rm -f "$TEMP_CRED_FILE"
  fi
}
trap cleanup EXIT

resolve_credentials_file() {
  if [[ -n "$WD_CREDENTIALS_FILE" ]]; then
    if [[ ! -f "$WD_CREDENTIALS_FILE" ]]; then
      log "WD_CREDENTIALS_FILE not found: ${WD_CREDENTIALS_FILE}"
      exit 1
    fi
    if [[ ! -r "$WD_CREDENTIALS_FILE" ]]; then
      log "WD_CREDENTIALS_FILE is not readable: ${WD_CREDENTIALS_FILE}"
      exit 1
    fi
    echo "$WD_CREDENTIALS_FILE"
    return
  fi
  if [[ -z "$WD_PASS" ]]; then
    log "Set WD_CREDENTIALS_FILE (preferred) or export WD_PASS for a temporary creds file"
    exit 1
  fi
  TEMP_CRED_FILE="$(mktemp)"
  chmod 600 "$TEMP_CRED_FILE"
  umask 077
  {
    echo "username=${WD_USER}"
    echo "password=${WD_PASS}"
  } >"$TEMP_CRED_FILE"
  echo "$TEMP_CRED_FILE"
}

CRED_FILE="$(resolve_credentials_file)"

log "Validating paths (source=${SOURCE}, mount=${MOUNT})"
if [[ ! -d "$SOURCE" ]]; then
  log "SOURCE does not exist or is not a directory: ${SOURCE}"
  exit 1
fi

RSYNC_OPTS=(-avh --stats)
if [[ "${RSYNC_DELETE:-}" == "1" ]]; then
  if [[ "${CONFIRM_DELETE:-}" != "yes" ]]; then
    log "Refusing rsync --delete: set CONFIRM_DELETE=yes with RSYNC_DELETE=1"
    exit 1
  fi
  RSYNC_OPTS+=(--delete)
fi
if [[ "$DRY_RUN" == true ]]; then
  RSYNC_OPTS+=(--dry-run)
  log "Dry-run mode: no changes will be written to the backup target"
fi

log "Mounting backup share (ensure NAS is powered on)"
mkdir -p "$MOUNT"
mount -t cifs "//${WD_HOST}/${WD_SHARE}" "$MOUNT" \
  -o "credentials=${CRED_FILE},${SMB_OPTS}" || { log "Mount failed"; exit 1; }

log "Starting rsync from ${SOURCE}"
rsync "${RSYNC_OPTS[@]}" "${SOURCE}/" "${MOUNT}/" | tee -a "$LOG"

log "Unmounting WD"
umount "$MOUNT"
log "Cold backup complete — power off backup NAS"
