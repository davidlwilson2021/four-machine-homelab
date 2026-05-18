# Claude Handoff Log

This folder is the cross-session, cross-device handoff layer for work done with Claude. Files are organized by category; the table below tracks what was added per session so I can find anything quickly.

## Folder Structure

```
claude-handoff/
├── README.md          ← this file (handoff log)
├── code/              ← scripts, snippets, executable artifacts
├── prompts/           ← prompt engineering work, system prompts, skills
├── coursework/        ← MSDS program work (DSC/550 active)
├── docs/              ← documentation, manuals, project plans, READMEs
└── misc/              ← anything that doesn't fit the above
```

## Handoff Log

| Date       | File(s)                                                              | Subfolder                | Destination       | Notes                                                                                                                  |
|------------|---------------------------------------------------------------------|--------------------------|-------------------|------------------------------------------------------------------------------------------------------------------------|
| 2026-05-17 | `README.md`, `docs/Lab-Architecture.md`, `docs/decisions.md`, `docs/phase-0..6-*.md`, `configs/network/*`, `configs/truenas/*`, `configs/mac-pro/docker-compose.yml`, `scripts/*.sh` | `homelab repo scaffold` | Local workspace | Four-machine scaffold completed and normalized. Added phase checklists, network templates, source-manual status tracking, and coherent cross-links. |
| 2026-05-03 | `Antsle-Homelab-Project.docx`, `README.md` (project)                | `docs/antsle-homelab/`   | Personal projects | Antsle One repurposed as TrueNAS Scale homelab. Full 15-section build manual + GitHub-ready README. Status: planning.  |

## Active Projects

### Four-machine homelab (active)
**Location:** workspace root (`README.md`, `docs/`, `configs/`, `scripts/`)
**Goal:** Enterprise-style segmented lab across Antsle, Mac Pro, MSI, and MacBook with an end-to-end MLOps portfolio loop.
**Current phase:** Phase 0 physical reassembly in progress; repo scaffold and execution artifacts are now in place.
**Next step:** Execute Phase 0 checklist, then rack and configure Phase 1 networking.
**References:** `docs/Lab-Architecture.md`, `docs/decisions.md`, `docs/source-manuals-status.md`

## Conventions

- New work created with Claude on mobile gets bundled into this folder structure at end of session
- `README.md` (this file) updated with every session that produces files
- Project subfolders inside `docs/` get their own README when they grow past a single file
- Files moved from this layer into permanent locations (Google Drive project folders, GitHub repos, NAS shares) should remain referenced here as historical record

## Session status (2026-05-17)

- Repo scaffold deliverables from the four-machine plan are present and linked coherently.
- Markdown conversion and architecture docs are readable with ASCII-friendly text.
- Source Word manuals are currently tracked as missing imports in `docs/source-manuals-status.md`.

## Session handoff
**Date / project:** 2026-05-17 / four-machine homelab  
**Goal:** Build Antsle first, then continue full lab phases  
**Branch / key paths:** `c:\Users\Home Network\.cursor\projects\home-lab-\claude_handoff`, plan at `c:\Users\Home Network\.cursor\plans\four-machine_homelab_build_3effb9d3.plan.md`  
**Completed:**  
- Build marked in progress  
- Sign-off decisions completed (VLAN/IP confirmed, Firewalla Option B, default phase order)  
- Word docs now present in workspace  
**In progress:** Phase 0 hardware (`phase-0-hardware: in_progress`)  
**Decisions (do not re-litigate):**  
- Antsle IP `[REDACTED_PRIVATE_IP]`, Mac Pro `[REDACTED_PRIVATE_IP]`, MSI `[REDACTED_PRIVATE_IP]`  
- Firewalla Option B (household edge unchanged; PA-3020 lab-only)  
- Phase order `0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6`  
**Next 3 steps:**  
1. Resume Phase 0 checkpoint 2 (POST/BIOS checks)  
2. Verify RAM 64GB + NVMe + 2x SATA detected  
3. Boot TrueNAS installer USB and report status  
**Files touched:**  
- `c:\Users\Home Network\.cursor\plans\four-machine_homelab_build_3effb9d3.plan.md`  
**Open questions:** none
