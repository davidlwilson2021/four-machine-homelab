# Phase 0 — Physical reassembly

**Done when:** Antsle, MSI, and Mac Pro power on, reach BIOS, and detect installed RAM and drives.

**References:**
- Antsle hardware manual import status: [source-manuals-status.md](source-manuals-status.md)
- MSI wiring: `host-06-codex-zs-wiring-context.md` (add to repo when available)
- Architecture: [Lab-Architecture.md](Lab-Architecture.md) §7 Phase 0

---

## Before you start

- [ ] Antsle unplugged from wall; hold power 5s to discharge
- [ ] Anti-static wrist strap or grounded metal touch habit
- [ ] Tools: Phillips #1 and #2, magnetic tray for screws
- [ ] VGA monitor + USB keyboard for Antsle first boot (board has VGA only)

---

## Antsle One

### RAM (DIMMA1 + DIMMB1 only)

- [ ] Open retention clips on **DIMMA1** and **DIMMB1**
- [ ] Seat 2× Micron 32GB DDR4-2933 ECC RDIMM (notch aligned)
- [ ] Retention clips snap closed; no DIMM movement when pressed

### M.2 boot (Samsung 980 500GB)

- [ ] Remove M.2 standoff screw; insert NVMe at ~30°; press flat; replace screw (snug)

### SATA pool (2× Crucial MX500 1TB)

- [ ] Mount both SSDs in 2.5" bays; SATA data to **I-SATA0** and **I-SATA1**
- [ ] SATA power from PSU to both drives

### Pre-power visual

- [ ] RAM seated; M.2 screwed; SATA data+power on both SSDs
- [ ] No loose screws/tools inside chassis
- [ ] Ethernet to **LAN1** (leftmost RJ45 next to IPMI); VGA + USB keyboard connected
- [ ] Power cable still **unplugged** until USB installer ready (Phase 2)

### POST verification

- [ ] Power on; BIOS shows **65536 MB** RAM (if 32768, reseat DIMMs)
- [ ] BIOS sees Samsung 980 NVMe + both Crucial MX500s
- [ ] Note: RAM may report **DDR4-2400** (downclock from 2933 — expected)

---

## MSI Codex ZS 5TC

- [ ] Reassemble per wiring reference doc
- [ ] Confirm RTX 3060 Ti seated and power connected
- [ ] POST: BIOS detects 16GB RAM, NVMe boot drive, GPU

---

## Mac Pro 5,1 (4,1 flashed)

- [ ] Power on; confirm 12C/24T and 64GB detected
- [ ] No changes required for Phase 0 unless drives missing

---

## Phase 0 complete

- [ ] Photo or notes of BIOS drive/RAM screens for each box
- [ ] Update [decisions.md](decisions.md) phase table: Phase 0 → complete
- [ ] Next: [Phase 1 network](phase-1-network-checklist.md)
