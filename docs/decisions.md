# Architecture decisions (sign-off log)

> Locked decisions from [Lab-Architecture.md](Lab-Architecture.md) §11. Update this file when you change topology.

**Signed off:** 2026-05-17 (execution start)

## 1. VLAN and addressing plan

**Decision:** Accept Lab Architecture §3.2–3.3 as written.

| VLAN | Subnet | Purpose | Key hosts |
|------|--------|---------|-----------|
| 1 | family-lan-subnet | Family LAN (untouched) | household devices |
| 10 | lab-mgmt-subnet | Lab management | firewall mgmt, switch mgmt, IPMI, admin client |
| 20 | lab-storage-subnet | Lab storage | Antsle data NIC |
| 30 | lab-compute-subnet | Lab compute | Mac Pro, MSI |
| 40 | lab-dmz-subnet | Lab DMZ (reserved) | Future exposed services |
| — | 100.x.x.x | Tailscale | Personal remote access |

**Notes:** Keep exact address assignments in a private operator runbook outside this public repository.

## 2. Firewalla disposition

**Decision:** **Option B** — Firewalla remains household edge; PA-3020 is lab perimeter only until PA is stable.

**Revisit:** After Phase 1, if PA management is comfortable, evaluate Option A (single edge).

## 3. Build phase sequence

**Decision:** Default order 0 → 1 → 2 → 3 → 4 → 5 → 6; Phase 7 (cyber) deferred.

| Phase | Name | Status |
|-------|------|--------|
| 0 | Physical reassembly | **In progress** |
| 1 | Network foundation | Pending |
| 2 | Antsle / TrueNAS | Pending |
| 3 | Antsle services | Pending |
| 4 | Mac Pro data platform | Pending |
| 5 | MSI AI workstation | Pending |
| 6 | MLOps loop | Pending |
| 7 | Cyber layering | Deferred |
