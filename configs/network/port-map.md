# Network port map

Fill this during Phase 1 racking/cabling so physical ports match policy and VLAN intent.

| Device | Local port | Remote device | Remote port | Mode | VLAN(s) | Notes |
|--------|------------|---------------|-------------|------|---------|-------|
| PA-3020 | ethernet1/x | Cisco 3750v2 | Gi1/0/x | trunk | 10,20,30,40 | Lab uplink |
| Cisco 3750v2 | Gi1/0/x | Antsle IPMI | IPMI | access | 10 | OOB management |
| Cisco 3750v2 | Gi1/0/x | Antsle LAN1 | LAN1 | access | 20 | TrueNAS data |
| Cisco 3750v2 | Gi1/0/x | Mac Pro | NIC1 | access | 30 | Data platform |
| Cisco 3750v2 | Gi1/0/x | MSI Codex | NIC1 | access | 30 | GPU node |

Update placeholders (`x`) with actual port numbers after install.
