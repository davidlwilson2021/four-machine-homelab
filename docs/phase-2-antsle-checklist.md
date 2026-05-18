# Phase 2 - Antsle TrueNAS build

Done when personal data is on Antsle, snapshots are running, and one cold-backup run succeeds.

## Preconditions

- [ ] Phase 1 complete (VLANs and routing validated)
- [ ] Antsle data NIC reachable at the storage-VLAN address from your private runbook
- [ ] Manual source reference confirmed in `docs/source-manuals-status.md`

## Build sequence

- [ ] Install/configure TrueNAS Scale and set management access
- [ ] Create `tank` mirror pool on 2x MX500 drives
- [ ] Create datasets from `configs/truenas/datasets.md`
- [ ] Apply snapshot schedule from `configs/truenas/snapshot-policy.md`
- [ ] Configure SMB shares and user permissions
- [ ] Validate MacBook and Windows access to SMB shares

## Migration and backup

- [ ] Run migration verification helper: `scripts/verify-migration.sh`
- [ ] Perform one cold-backup run: `scripts/cold-backup-rsync.sh`
- [ ] Confirm backup log and checksum/file-count confidence

## Exit criteria

- [ ] Antsle is serving production personal data on the storage-VLAN address from your private runbook
- [ ] Snapshots are active and visible in Data Protection UI
- [ ] Cold backup completed at least once without error
