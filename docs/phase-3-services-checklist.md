# Phase 3 - Antsle services

Done when third-party equivalents are retired for at least core password, DNS, and sensitive file workflows.

## Service rollout order

- [ ] Nextcloud
- [ ] Vaultwarden
- [ ] Pi-hole
- [ ] Jellyfin (optional)
- [ ] Syncthing (optional)

## Per-service gate

- [ ] Install app and pin image/version where practical
- [ ] Configure persistent storage dataset in `tank/apps`
- [ ] Add DNS/hostname and access policy notes
- [ ] Validate backups include service data
- [ ] Record rollback path before replacing existing service

## Exit criteria

- [ ] Core replacements are in daily use
- [ ] Legacy third-party dependencies reduced as planned
- [ ] Service inventory documented in project notes
