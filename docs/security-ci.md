# Security CI and dependency policy

## Secret scanning

- **gitleaks** runs on every push and pull request via [.github/workflows/gitleaks.yml](../.github/workflows/gitleaks.yml).
- Local check: `gitleaks detect --source . --verbose`

## Credential hygiene (git history)

Early scaffold commits documented weak Docker fallbacks (`changeme`, all-interface binds). The current tree requires env secrets and localhost binds.

**If you ever deployed from an old revision:** rotate Postgres and MinIO credentials before returning the stack to service. No `git filter-repo` is required unless you want a cleaner public history for showcase purposes.

## Dependencies (when code is added)

This repository is mostly docs and configs today. When you add application code:

1. Commit lockfiles (`package-lock.json`, `poetry.lock`, `requirements.txt` with hashes, etc.).
2. Add a CI job with [Trivy](https://github.com/aquasecurity/trivy-action) or language-native audit (`npm audit`, `pip-audit`, etc.).
3. Pin container image tags or digests in compose files; avoid mutable `latest` tags.
