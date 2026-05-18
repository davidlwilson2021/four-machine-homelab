# Phase 1 — Network foundation

**Done when:** VLANs 10/20/30/40 routable; Palo Alto policy enforced; family LAN ([REDACTED_PRIVATE_IP]/24) unaffected.

**Reference:** [Lab-Architecture.md](Lab-Architecture.md) §3, [decisions.md](decisions.md), [configs/network/vlan-plan.md](../configs/network/vlan-plan.md)

---

## Topology (Option B)

```
Cox ONT → Firewalla (household) → PA-3020 (lab) → Cisco 3750v2 → lab VLANs
                              → Amplifi (family LAN, unchanged)
```

---

## Physical

- [ ] Rack Cisco + PA; cable per architecture §3.1
- [ ] Trunk from PA to Cisco carrying VLANs 10, 20, 30, 40
- [ ] Antsle: mgmt/IPMI → VLAN 10; LAN1 data → VLAN 20
- [ ] Mac Pro + MSI → VLAN 30 access ports
- [ ] Label ports in `configs/network/port-map.md` (create as you wire)

---

## Cisco 3750v2

- [ ] Management IP **[REDACTED_PRIVATE_IP]/24** on VLAN 10
- [ ] Create VLANs 10, 20, 30, 40
- [ ] SVIs or routed interfaces for inter-VLAN (per your design)
- [ ] DHCP helper or local DHCP scopes per VLAN (or static reservations)
- [ ] ACLs: default deny between zones except documented allows

---

## Palo Alto PA-3020

- [ ] Management **[REDACTED_PRIVATE_IP]/24**
- [ ] Zones: trust (lab), untrust (upstream to Firewalla), optional dmz
- [ ] Policies: lab ↔ lab per matrix; lab → internet; block lab → family except explicit
- [ ] No threat prevention licenses — document as portfolio limitation

---

## Validation

- [ ] MacBook on VLAN 10: ping [REDACTED_PRIVATE_IP], .2, .10 (IPMI)
- [ ] From VLAN 30: reach [REDACTED_PRIVATE_IP] only if policy allows (post-Antsle)
- [ ] Family device on private-home-subnet: internet works; cannot reach lab-mgmt-subnet (unless intended)
- [ ] Kill-A-Watt readings noted in Lab-Architecture §8.3

---

## Next

Phase 2 - follow [phase-2-antsle-checklist.md](phase-2-antsle-checklist.md) and use **[REDACTED_PRIVATE_IP]** for TrueNAS UI and SMB.
