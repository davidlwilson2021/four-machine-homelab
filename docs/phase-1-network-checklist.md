# Phase 1 — Network foundation

**Done when:** VLANs 10/20/30/40 routable; Palo Alto policy enforced; family LAN unaffected.

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

- [ ] Management address configured on VLAN 10 per private runbook
- [ ] Create VLANs 10, 20, 30, 40
- [ ] SVIs or routed interfaces for inter-VLAN (per your design)
- [ ] DHCP helper or local DHCP scopes per VLAN (or static reservations)
- [ ] ACLs: default deny between zones except documented allows

---

## Palo Alto PA-3020

- [ ] Management address configured per private runbook
- [ ] Zones: trust (lab), untrust (upstream to Firewalla), optional dmz
- [ ] Policies: lab ↔ lab per matrix; lab → internet; block lab → family except explicit
- [ ] No threat prevention licenses — document as portfolio limitation

---

## Validation

- [ ] Admin client on VLAN 10 can reach firewall/switch/IPMI management targets
- [ ] From VLAN 30, storage endpoint access only works where policy explicitly allows it
- [ ] Family LAN devices still have internet and cannot reach lab subnets unless explicitly allowed
- [ ] Kill-A-Watt readings noted in Lab-Architecture §8.3

---

## Next

Phase 2 - follow [phase-2-antsle-checklist.md](phase-2-antsle-checklist.md) and use private addressing references from your operator runbook.
