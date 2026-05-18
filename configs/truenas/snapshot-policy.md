# Snapshot policy (Phase 2)

Configure under **Data Protection → Periodic Snapshot Tasks**.

## tank/documents

| Task | Schedule | Lifetime | Recursive |
|------|----------|----------|-----------|
| Hourly | Every hour | 24 hours | Yes |
| Daily | 02:00 daily | 30 days | Yes |
| Weekly | Sunday 03:00 | 12 weeks | Yes |

## tank/media

Shorter retention (example):

| Task | Lifetime |
|------|----------|
| Hourly | 7 days |
| Daily | 14 days |

Snapshots are **not** a substitute for cold backup — see `scripts/cold-backup-rsync.sh`.
