# PA-3020 policy matrix (Option B)

This matrix captures intended allow/deny behavior before rule implementation.

| Source zone/subnet | Destination zone/subnet | Service | Action | Reason |
|--------------------|-------------------------|---------|--------|--------|
| Lab mgmt `lab-mgmt-subnet` | Lab storage `lab-storage-subnet` | HTTPS/SSH/ICMP | Allow | Admin access to storage/infra |
| Lab compute `lab-compute-subnet` | Lab storage `lab-storage-subnet` | SMB/NFS/MinIO as needed | Allow (scoped) | Data path for pipelines |
| Lab storage `lab-storage-subnet` | Lab compute `lab-compute-subnet` | Established/related | Allow | Return traffic only |
| Lab VLANs `lab-address-space` | Internet | HTTPS (443), DNS (53), NTP (123) only | Allow (tight) | Package pulls and updates — deny all other egress |
| Lab VLANs `lab-address-space` | Family LAN `family-lan-subnet` | Any | Deny | Household isolation |
| Family LAN `family-lan-subnet` | Lab VLANs `lab-address-space` | Any | Deny | Household isolation |
| Any | DMZ `lab-dmz-subnet` | Any | Deny by default | Future zone reserved |

## Notes

- When implementing the lab → Internet rule, use application filters or service objects for HTTPS/DNS/NTP only; log denies; review hits weekly during Phase 1.
- Keep logging on all deny rules for early troubleshooting.
- Keep Tailscale as primary remote path for daily admin workflows.
- Re-evaluate policy if transitioning from Firewalla Option B to Option A later.
