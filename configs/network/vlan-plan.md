# VLAN and IP plan

Canonical copy of [decisions.md](../../docs/decisions.md) section 1 for device configuration.

| VLAN ID | Name | Subnet | Gateway (typical) |
|---------|------|--------|-------------------|
| 1 | family | family-lan-subnet | household-edge-gateway |
| 10 | lab-mgmt | lab-mgmt-subnet | mgmt-gateway |
| 20 | lab-storage | lab-storage-subnet | storage-gateway |
| 30 | lab-compute | lab-compute-subnet | compute-gateway |
| 40 | lab-dmz | lab-dmz-subnet | dmz-gateway (reserved) |

## Static assignments

| Host role | Address reference |
|-----------|-------------------|
| host-01 | mgmt-gateway |
| host-02 | mgmt-switch |
| host-03 | host-03-host |
| host-04 | antsle-storage-host |
| host-05 | host-05-compute-host |
| host-06 | host-06-compute-host |

## Tailscale

Install on Antsle (TrueNAS app), MacBook, Windows, iPhone per Antsle manual §9. Use MagicDNS hostnames for remote SMB/UI.

## Related artifacts

- `configs/network/cisco-3750v2-template.conf`
- `configs/network/pa-3020-policy-matrix.md`
- `configs/network/port-map.md`
