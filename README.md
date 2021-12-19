# Build Date

## Update Containerfile build_date label

This [pre-commit](https://pre-commit.com/) hook will update the `build_date` label in your Container file before commiting if it is older than 3 hours.

Expand (or create) your `.pre-commit-config.yml` with this section:

```yaml
repos:
  - repo: https://github.com/ucomesdag/build-date
    rev: v0.0.0
    hooks:
      - id: container_build_date
```
