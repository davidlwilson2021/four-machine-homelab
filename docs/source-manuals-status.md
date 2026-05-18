# Source manuals status

This workspace uses `docs/Lab-Architecture.md` as the tracked Markdown source of truth.

## Manual inventory

| Manual | Expected repo path | Status | Notes |
|--------|--------------------|--------|-------|
| Lab Architecture (Word) | `files/Lab-Architecture.md.docx` | Not present in this workspace | Markdown conversion exists at `docs/Lab-Architecture.md` and is the canonical tracked version here. |
| Antsle execution manual (Word) | `docs/antsle/Antsle-Homelab-Project.docx` | Not present in this workspace | Use the private ops repository (`four-machine-homelab-ops/handoff/`) for prior handoff artifact history until docx is re-imported. |

## Action when manual files are available

1. Copy Word sources into the expected repo paths above.
2. Keep `docs/Lab-Architecture.md` as the primary version-controlled design doc.
3. Keep Antsle manual authoritative for Phase 2 procedural steps.
4. Update this file and the private ops handoff log (`four-machine-homelab-ops/handoff/handoff-log-README.md`) with the import timestamp.
