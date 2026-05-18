# PA-3020 policy matrix (Option B)

This matrix captures intended allow/deny behavior before rule implementation.

| Source zone/subnet | Destination zone/subnet | Service | Action | Reason |
|--------------------|-------------------------|---------|--------|--------|
| Lab mgmt `[REDACTED_PRIVATE_IP]/24` | Lab storage `[REDACTED_PRIVATE_IP]/24` | HTTPS/SSH/ICMP | Allow | Admin access to Antsle/infra |
| Lab compute `[REDACTED_PRIVATE_IP]/24` | Lab storage `[REDACTED_PRIVATE_IP]/24` | SMB/NFS/MinIO as needed | Allow (scoped) | Data path for pipelines |
| Lab storage `[REDACTED_PRIVATE_IP]/24` | Lab compute `[REDACTED_PRIVATE_IP]/24` | Established/related | Allow | Return traffic only |
| Lab VLANs `[REDACTED_PRIVATE_IP]/16` | Internet | Required app ports | Allow | Package pulls and updates |
| Lab VLANs `[REDACTED_PRIVATE_IP]/16` | Family LAN `[REDACTED_PRIVATE_IP]/24` | Any | Deny | Household isolation |
| Family LAN `[REDACTED_PRIVATE_IP]/24` | Lab VLANs `[REDACTED_PRIVATE_IP]/16` | Any | Deny | Household isolation |
| Any | DMZ `[REDACTED_PRIVATE_IP]/24` | Any | Deny by default | Future zone reserved |

## Notes

- Keep logging on all deny rules for early troubleshooting.
- Keep Tailscale as primary remote path for daily admin workflows.
- Re-evaluate policy if transitioning from Firewalla Option B to Option A later.
