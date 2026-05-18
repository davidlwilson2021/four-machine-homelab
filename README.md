# Home Lab — Four-Machine Architecture

> Enterprise-style home lab: TrueNAS storage, Cisco + Palo Alto networking, Mac Pro data platform, MSI GPU workstation, end-to-end MLOps — built as a portfolio piece for AI/data engineering roles.

![Status](https://img.shields.io/badge/status-phase_0_in_progress-yellow)
![Design](https://img.shields.io/badge/design-Lab_Architecture-blue)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Start here

| Document | Purpose |
|----------|---------|
| **[docs/Lab-Architecture.md](docs/Lab-Architecture.md)** | Primary design: roles, VLANs, MLOps loop, phases |
| **[docs/decisions.md](docs/decisions.md)** | Signed VLAN/IP plan, Firewalla disposition, phase order |
| **[docs/phase-0-checklist.md](docs/phase-0-checklist.md)** | Current execution checklist: physical reassembly |
| **[docs/source-manuals-status.md](docs/source-manuals-status.md)** | Manual source-of-truth status and import paths |

---

## Machines

| Machine | Role | Lab IP |
|---------|------|--------|
| Antsle One | TrueNAS Scale, ZFS, personal services | [REDACTED_PRIVATE_IP] |
| Mac Pro 5,1 | Postgres, MinIO, Airflow, Jupyter | [REDACTED_PRIVATE_IP] |
| MSI Codex ZS 5TC | Ollama / GPU inference & training | [REDACTED_PRIVATE_IP] |
| MacBook M1 | Thin client, admin | [REDACTED_PRIVATE_IP] (DHCP) |

**Network:** Cisco 3750v2 core, Palo Alto PA-3020 lab perimeter, Firewalla household edge (Option B). Remote access via Tailscale.

---

## Build phases

| Phase | Status |
|-------|--------|
| 0 Physical reassembly | In progress |
| 1 Network foundation | Pending ([checklist](docs/phase-1-network-checklist.md)) |
| 2 Antsle / TrueNAS | Pending ([checklist](docs/phase-2-antsle-checklist.md)) |
| 3 Antsle services | Pending ([checklist](docs/phase-3-services-checklist.md)) |
| 4 Mac Pro platform | Pending ([checklist](docs/phase-4-mac-pro-checklist.md)) |
| 5 MSI AI workstation | Pending ([checklist](docs/phase-5-host-06-checklist.md)) |
| 6 MLOps loop | Pending ([checklist](docs/phase-6-mlops-checklist.md)) |
| 7 Cyber (deferred) | — |

---

## Repository layout

```
docs/           Architecture, sign-offs, and execution checklists by phase
configs/        Network snippets, TrueNAS dataset/snapshot baselines, Mac Pro compose
scripts/        Cold-backup rsync and migration verification helpers
```

---

## Sync (manual)

- **NAS mirror:** `\\MYCLOUDEX2ULTRA\Projects\ai-workspace\cursor-workspace\homelab`
- **Git remote:** Initialize and push when ready (`git remote add origin …`)

---

## Author

**David Wilson** — MS Data Science, cybersecurity background, homelab as portfolio infrastructure.

MIT License — see [LICENSE](LICENSE).
