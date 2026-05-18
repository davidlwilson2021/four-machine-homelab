# Phase 5 - MSI AI workstation

Done when a local LLM is reachable from MacBook and a working RAG demo uses Mac Pro data context.

## Workstation setup

- [ ] Install Linux plus NVIDIA drivers/CUDA toolkit
- [ ] Install Docker runtime with GPU support
- [ ] Deploy Ollama and Open WebUI
- [ ] Validate GPU visibility and model load performance

## Inference exposure (before MacBook access)

- [ ] Bind Ollama/Open WebUI to MSI compute VLAN address or Tailscale — not public `0.0.0.0`
- [ ] Enable WebUI authentication; disable anonymous admin
- [ ] Block inbound from family LAN and Internet at PA-3020 (lab isolation matrix)
- [ ] Prefer Tailscale for remote inference; avoid port forwarding on Firewalla

## Data integration

- [ ] Pull feature data/artifacts from MinIO on VLAN 30
- [ ] Run one training or fine-tune workload
- [ ] Push resulting model artifact back to MinIO

## Validation

- [ ] MacBook can access UI/inference endpoint
- [ ] RAG response uses Mac Pro/Postgres-backed context
- [ ] Record RAM pressure and decide if 32GB upgrade is needed
