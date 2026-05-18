# Antsle Homelab Project

> Repurposing a decommissioned Antsle One virtualization server into a TrueNAS Scale homelab — replacing an aging WD My Cloud with mirrored ZFS storage, ECC RAM, encrypted remote access, and a true 3-2-1 backup architecture.

![Status](https://img.shields.io/badge/status-planning-blue)
![Platform](https://img.shields.io/badge/platform-TrueNAS_Scale-005999)
![Hardware](https://img.shields.io/badge/hardware-Supermicro_A2SDi--8C--HLN4F-orange)
![License](https://img.shields.io/badge/license-MIT-green)

---

## Why This Project Exists

My current home storage setup is a single-drive WD My Cloud EX2 Ultra. It works, but it has gaps I want to close:

- **No real redundancy** — single point of failure on the active data
- **Third-party cloud relay** for remote access (mycloud.com / cf2.remotewd.com) that I don't control
- **Limited security updates** from Western Digital on an aging platform
- **No snapshots, no versioning** — accidental deletion is permanent

I have an Antsle One sitting unused that originally shipped as a turnkey virtualization appliance. The hardware inside (Supermicro A2SDi-8C-HLN4F, 8-core Atom C3758, 12 SATA ports, ECC RAM support, fanless chassis) is genuinely well-suited to running TrueNAS Scale as an always-on home infrastructure backbone. So the plan is to repurpose it.

This repo documents the design, the build plan, and the reasoning behind the decisions.

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                      LIVE DATA LAYER                            │
│  Antsle (TrueNAS Scale)                                         │
│  ┌──────────────┐   ┌─────────────────────────────────┐         │
│  │  Boot: M.2   │   │  tank pool (ZFS Mirror)         │         │
│  │  Samsung 980 │   │  2× Crucial MX500 1TB           │         │
│  │  500GB NVMe  │   │  ~931 GiB usable, redundant     │         │
│  └──────────────┘   └─────────────────────────────────┘         │
│         │                    │                                  │
│         │              ┌─────┴──────┐                           │
│         │              │ Snapshots  │  hourly / daily / weekly  │
│         │              └────────────┘                           │
└─────────┼──────────────────────┼────────────────────────────────┘
          │                      │
          │ Tailscale            │ rsync push (manual, weekly)
          │ (encrypted mesh)     │
          ▼                      ▼
   ┌──────────────┐       ┌────────────────────┐
   │  Remote      │       │  WD My Cloud       │
   │  Devices     │       │  (offline cold     │
   │  (Mac/Win/   │       │  backup target)    │
   │  iPhone)     │       │  Powered off 99%   │
   └──────────────┘       └────────────────────┘
```

### Data Resilience (3-2-1 Backup Rule)

| Layer        | Location              | Purpose                          | Recovery Time |
|--------------|----------------------|----------------------------------|---------------|
| Live         | Antsle MX500 mirror  | Active daily-use data            | Instant       |
| Snapshots    | Antsle MX500 mirror  | Recent versions, undo mistakes   | Seconds       |
| Cloud sync   | Google Drive         | Cross-device, offsite            | Minutes       |
| Cold backup  | WD My Cloud (offline)| Disaster + ransomware protection | Hours         |

---

## Hardware

| Component     | Specification                                          |
|---------------|--------------------------------------------------------|
| Chassis       | Antsle One — fanless, passively cooled                |
| Motherboard   | Supermicro A2SDi-8C-HLN4F (Mini-ITX)                  |
| CPU           | Intel Atom C3758 — 8 cores, 25W TDP, soldered         |
| RAM           | 64GB (2× Micron 32GB DDR4-2933 ECC RDIMM)             |
| Boot drive    | Samsung 980 NVMe 500GB (M.2)                          |
| Storage pool  | 2× Crucial MX500 1TB SATA SSD — ZFS mirror            |
| Network       | 4× Gigabit Ethernet + dedicated IPMI                  |
| Power draw    | ~30W typical (24/7 operation)                         |

### Why This Hardware

The Atom C3758 is not fast in single-thread benchmarks, but the workload here is overwhelmingly I/O-bound, not compute-bound. What this platform does extremely well:

- **Always-on at low power** (25W TDP — pennies per month on electricity)
- **ECC RAM support** (matters for ZFS data integrity — protects against silent bit corruption in cache)
- **12 SATA ports** (massive room to scale storage past current needs)
- **Fanless cooling** (sits anywhere in the house, completely silent)

64GB ECC is the spec that actually drives the decision. ZFS uses RAM aggressively as adaptive read cache (ARC), and ECC ensures data flowing through that cache cannot be silently corrupted.

---

## Software Stack

| Layer            | Choice               | Rationale                                          |
|------------------|----------------------|----------------------------------------------------|
| Operating system | TrueNAS Scale        | Free, ZFS-native, GUI-driven, large app catalog    |
| Filesystem       | ZFS (mirror vdev)    | Snapshots, checksums, self-healing, mature         |
| Remote access    | Tailscale (free tier)| WireGuard mesh, no port forwarding, e2e encrypted  |
| Sharing protocol | SMB                  | Native macOS, Windows, iOS support                 |
| Backup tool      | rsync                | Idempotent, resumable, preserves permissions       |
| Mac backups      | Time Machine over SMB| Built into macOS, automatic                        |

### Self-Hosted Services (Phased Rollout)

1. **Nextcloud** — file sync, reduces dependency on Google Drive for sensitive data
2. **Vaultwarden** — self-hosted Bitwarden, replaces password manager subscription
3. **Pi-hole** — network-wide DNS-based ad blocking
4. **Jellyfin** — media library (optional)
5. **Syncthing** — peer-to-peer device sync (optional)

---

## Key Design Decisions

### Mirror over RAID-Z1
With only two drives, both layouts give the same usable capacity. Mirror wins on random I/O performance, faster rebuild times after a drive replacement, and simpler expansion paths. RAID-Z1 makes more sense at 3+ drives.

### Single-disk boot pool
The boot drive holds the OS — it can be reinstalled in 15 minutes. The data pool is the part that actually matters and that's where I spent the redundancy budget. Mirroring the boot drive would be a luxury, not a requirement.

### No encryption on the data pool
Encryption complicates recovery (key required to import the pool on replacement hardware) and doesn't materially protect against my actual threat model. Physical theft is low-probability, and data already syncs to Google Drive encrypted in transit and at rest.

### Cold backup over continuous backup
The WD My Cloud stays powered off most of the time, only waking up for periodic backup runs. This is intentional — the offline-by-default state provides ransomware and accidental-deletion immunity that no online backup can match. 5 minutes per week of manual effort buys true offline protection.

### Tailscale over self-hosted VPN
WireGuard mesh with peer-to-peer connections, no port forwarding required, free for personal scale (100 devices, 3 users). Setting up OpenVPN or self-hosted WireGuard would take a weekend and produce a worse result for this use case.

---

## Repository Contents

```
.
├── README.md                              # You are here
├── docs/
│   └── Antsle-Homelab-Project.docx        # Full build manual (15 sections)
├── scripts/                               # (Future) automation and helper scripts
└── configs/                               # (Future) example configs and snippets
```

The Word document is the executable build plan — sections proceed in the order I plan to execute them. The README is meant as project overview and quick reference.

---

## Build Phases

### Phase 1 — Foundation (Session 1, ~3 hours)
- [ ] Install RAM, M.2, SATA SSDs into Antsle chassis
- [ ] Flash TrueNAS Scale installer USB
- [ ] Install TrueNAS Scale to NVMe boot drive
- [ ] Initial web UI configuration, DHCP reservation, hostname
- [ ] Apply pending updates

### Phase 2 — Storage and Sharing (Session 1 cont., ~1 hour)
- [ ] Create `tank` ZFS mirror pool
- [ ] Create datasets: documents, media, backups, timemachine, apps
- [ ] Configure tiered snapshot policy (hourly/daily/weekly)
- [ ] Create local user, set dataset permissions
- [ ] Enable SMB service, create shares
- [ ] Mount shares on MacBook and Windows desktop
- [ ] Configure Time Machine over SMB

### Phase 3 — Remote Access (Session 1 cont., ~30 min)
- [ ] Install Tailscale app on TrueNAS
- [ ] Authenticate Antsle to Tailscale tailnet
- [ ] Install Tailscale clients on MacBook, Windows, iPhone
- [ ] Verify remote SMB and web UI access from off-LAN

### Phase 4 — Migration (Session 2, ~2-4 hours)
- [ ] Inventory existing WD My Cloud data
- [ ] Mount WD share on TrueNAS (read-only)
- [ ] rsync transfer to `tank/documents`
- [ ] Verify file count and size match
- [ ] Apply correct ownership and permissions

### Phase 5 — Cold Backup (Session 2 cont., ~30 min)
- [ ] Factory reset WD My Cloud
- [ ] Configure as cold backup target (single share, no cloud access)
- [ ] Create rsync push task in TrueNAS (manual schedule)
- [ ] Test first cold backup run end-to-end
- [ ] Document the weekly ritual

### Phase 6 — Services (Session 3+, paced)
- [ ] Install and configure Nextcloud
- [ ] Install and configure Vaultwarden
- [ ] Install and configure Pi-hole, point router DNS
- [ ] Install Jellyfin (optional)

---

## Operations Cadence

| Frequency  | Task              | Notes                                              |
|------------|-------------------|----------------------------------------------------|
| Weekly     | Cold backup       | Power on WD, run rsync, power off WD               |
| Weekly     | Health check      | TrueNAS dashboard glance — pool/disks/alerts       |
| Monthly    | System updates    | TrueNAS Scale and installed apps                   |
| Quarterly  | Pool scrub        | Verifies data integrity across all blocks          |
| Quarterly  | Restore drill     | Pick a file, restore from snapshot, verify         |

---

## What This Replaces / Decommissions

- WD My Cloud as primary NAS → repurposed to cold backup
- WD My Cloud cloud access (mycloud.com) → disabled, replaced by Tailscale
- WD My Cloud relay (cf2.remotewd.com) → no longer needed
- Single point of failure storage → replaced by ZFS mirror
- "Hope I don't delete the wrong thing" → replaced by tiered snapshot policy

---

## Future Considerations

Not part of the initial build, but possible follow-ups on this same platform:

- Off-site replication to Backblaze B2 or rsync.net for true geographic redundancy
- ZFS replication (`zfs send | zfs recv`) instead of rsync for the cold backup — preserves snapshots
- Adding 2× larger NAS-grade HDDs (WD Red Plus or Seagate IronWolf) as a second pool for media/bulk storage
- Home Assistant for IoT and home automation
- Self-hosted Git (Gitea or Forgejo) for personal projects
- Network-level VLAN segmentation for IoT devices

---

## References and Further Reading

- [TrueNAS Scale documentation](https://www.truenas.com/docs/scale/)
- [Supermicro A2SDi-8C-HLN4F product page](https://www.supermicro.com/products/motherboard/atom/a2sdi-8c-hln4f.cfm)
- [ZFS administration guide](https://openzfs.github.io/openzfs-docs/)
- [Tailscale documentation](https://tailscale.com/kb/)
- [The 3-2-1 backup rule (Veeam)](https://www.veeam.com/blog/321-backup-rule.html)

---

## Author

**David Wilson**
IT Specialist (SYSADMIN) and MS Data Science candidate

This project is part of a portfolio of personal infrastructure and automation work. The full build manual lives in `docs/Antsle-Homelab-Project.docx`.

---

## License

MIT — see [LICENSE](LICENSE) for details. Do whatever you want with the build plan, designs, and documentation. If it helps you build your own homelab, that's the whole point.
