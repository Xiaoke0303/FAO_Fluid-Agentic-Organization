# pua Quarantine Record

## Original Path

`archives/non-skill-projects/pua/`

## Quarantine Path

`~/.openclaw/quarantine/pua-2026-04-29/pua/`

## Source

https://github.com/tanweai/pua.git

## Recorded Commit

5789b84

## Quarantine Date

2026-04-29

## Reason

- Third-party public repository
- Not FAO asset
- Not OpenClaw skill
- Name has misunderstanding / reputational risk
- Submodule dirty state polluted main repo
- Not needed for current FAO runtime

## Current State

- `quarantined`
- `not loaded`
- `not registered`
- `not executed`
- `not tracked as submodule`

## Recovery

- Restore from quarantine path, or re-clone from upstream if ever needed
- Requires human confirmation

## Execution Record

- Operator: FAO skills governance (P1-4d-fix)
- Method: mv out of repo, no scripts run, no network access
