# VLAN and IP plan

Canonical copy of [decisions.md](../../docs/decisions.md) section 1 for device configuration.

| VLAN ID | Name | Subnet | Gateway (typical) |
|---------|------|--------|-------------------|
| 1 | family | [REDACTED_PRIVATE_IP]/24 | Firewalla |
| 10 | lab-mgmt | [REDACTED_PRIVATE_IP]/24 | [REDACTED_PRIVATE_IP] (PA) or .2 (Cisco) |
| 20 | lab-storage | [REDACTED_PRIVATE_IP]/24 | [REDACTED_PRIVATE_IP] (Cisco SVI) |
| 30 | lab-compute | [REDACTED_PRIVATE_IP]/24 | [REDACTED_PRIVATE_IP] (Cisco SVI) |
| 40 | lab-dmz | [REDACTED_PRIVATE_IP]/24 | [REDACTED_PRIVATE_IP] (Cisco SVI, reserved) |

## Static assignments

| Host | IP |
|------|-----|
| host-01 | [REDACTED_PRIVATE_IP] |
| host-02 | [REDACTED_PRIVATE_IP] |
| host-03 | [REDACTED_PRIVATE_IP] |
| host-04 | [REDACTED_PRIVATE_IP] |
| host-05 | [REDACTED_PRIVATE_IP] |
| host-06 | [REDACTED_PRIVATE_IP] |

## Tailscale

Install on Antsle (TrueNAS app), MacBook, Windows, iPhone per Antsle manual §9. Use MagicDNS hostnames for remote SMB/UI.

## Related artifacts

- `configs/network/cisco-3750v2-template.conf`
- `configs/network/pa-3020-policy-matrix.md`
- `configs/network/port-map.md`
