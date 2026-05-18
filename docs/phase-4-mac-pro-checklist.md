# Phase 4 - Mac Pro data platform

Done when MacBook can run Jupyter workloads against Postgres and MinIO on the Mac Pro and a non-trivial Airflow DAG succeeds.

## Platform bring-up

- [ ] Install Linux and Docker on Mac Pro (compute VLAN host from private runbook)
- [ ] Copy `configs/mac-pro/docker-compose.yml` and define env vars
- [ ] Start stack and verify `postgres` and `minio` health
- [ ] Add Airflow and Jupyter services for full phase target

## Validation

- [ ] Connect from MacBook to Jupyter endpoint
- [ ] Query Postgres and read/write MinIO bucket
- [ ] Run one DAG with retries and artifact output
- [ ] Capture observed HDD performance baseline

## Upgrade gate

- [ ] Decide SSD upgrade only if measured bottleneck is material
- [ ] Record cost/benefit in architecture notes
