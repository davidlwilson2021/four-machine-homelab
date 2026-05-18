# Architecture decisions (sign-off log)

> Locked decisions from [Lab-Architecture.md](Lab-Architecture.md) §11. Update this file when you change topology.

**Signed off:** 2026-05-17 (execution start)

## 1. VLAN and IP plan

**Decision:** Accept Lab Architecture §3.2–3.3 as written.

| VLAN | Subnet | Purpose | Key hosts |
|------|--------|---------|-----------|
| 1 | [REDACTED_PRIVATE_IP]/24 | Family LAN (untouched) | Amplifi, household devices |
| 10 | [REDACTED_PRIVATE_IP]/24 | Lab management | PA `.1`, Cisco `.2`, Antsle IPMI `.10`, MacBook DHCP `.50` |
| 20 | [REDACTED_PRIVATE_IP]/24 | Lab storage | Antsle data NIC **[REDACTED_PRIVATE_IP]** |
| 30 | [REDACTED_PRIVATE_IP]/24 | Lab compute | Mac Pro **[REDACTED_PRIVATE_IP]**, MSI **[REDACTED_PRIVATE_IP]** |
| 40 | [REDACTED_PRIVATE_IP]/24 | Lab DMZ (reserved) | Future exposed services |
| — | 100.x.x.x | Tailscale | Personal remote access |

**Notes:** Phase 2 Antsle manual examples using `[REDACTED_PRIVATE_IP]` map to **[REDACTED_PRIVATE_IP]** on VLAN 20.

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
