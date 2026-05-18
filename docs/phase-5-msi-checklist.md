# Phase 5 - MSI AI workstation

Done when a local LLM is reachable from MacBook and a working RAG demo uses Mac Pro data context.

## Workstation setup

- [ ] Install Linux plus NVIDIA drivers/CUDA toolkit
- [ ] Install Docker runtime with GPU support
- [ ] Deploy Ollama and Open WebUI
- [ ] Validate GPU visibility and model load performance

## Data integration

- [ ] Pull feature data/artifacts from MinIO on VLAN 30
- [ ] Run one training or fine-tune workload
- [ ] Push resulting model artifact back to MinIO

## Validation

- [ ] MacBook can access UI/inference endpoint
- [ ] RAG response uses Mac Pro/Postgres-backed context
- [ ] Record RAM pressure and decide if 32GB upgrade is needed
