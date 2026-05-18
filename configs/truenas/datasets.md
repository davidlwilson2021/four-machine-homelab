# TrueNAS datasets (Phase 2)

Pool name: **tank** (ZFS mirror, 2× Crucial MX500 1TB)

| Dataset | Purpose | Notes |
|---------|---------|-------|
| `tank/documents` | Personal files | Home dir for `admin-user`; SMB `documents` |
| `tank/media` | Media library | SMB `media` |
| `tank/backups` | General backups | |
| `tank/timemachine` | Mac Time Machine | Sync=Standard, Compression=LZ4, Atime=Off |
| `tank/apps` | TrueNAS app volumes | Nextcloud, Vaultwarden, etc. |
| `tank/projects` | Promoted ML/portfolio data | From Mac Pro/MSI when worth keeping |

Permissions: owner `admin-user:admin-group`, recursive apply per Antsle manual §8.2.
