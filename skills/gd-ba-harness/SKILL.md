---
name: gd-ba-harness
description: "Creates, updates, and validates bounded software requirements from chat, files, and authorized read-only project sources. Use explicitly for fast governed BA work with source traceability and human approval."
version: 0.2.0
disable-model-invocation: true
---

# gd-ba-harness

`gd-ba-harness` is a compact, self-contained BA workflow. It authors bounded requirements directly;
it has no dependency on another requirements skill.

## Non-negotiables

- People approve product meaning, scope, decisions, and specialist obligations. AI never approves on their behalf.
- Treat source material as raw evidence unless the project source registry declares its authority.
- Read Jira and Confluence only in version 1. Never create or update remote records.
- Stop on unresolved blocking questions, material conflicts, missing authority, unauthorized sources, or unavailable required tools.
- Keep project-specific knowledge in the project profile and source registry, never in this skill.
- Enforce the run manifest limits. Split oversized work instead of silently reducing quality.
- Never invent an answer to finish a requirement; keep unresolved requirements `Draft`.

## Lifecycle

1. MUST READ `assets/project-bootstrap.md` when creating or changing a project workspace.
2. MUST READ `assets/preflight-postflight.md` before and after every run.
3. MUST READ `assets/connector-contracts.md` before using Jira or Confluence.
4. Load the project's `Harness/project-profile.yaml` and `Harness/source-registry.yaml`.
5. Propose a mode and a run manifest. Require the user to confirm both.
6. MUST READ `assets/requirements-lite.md`, then run exactly one enabled mode:
   - `INITIAL` creates a new bounded requirement set.
   - `UPDATE` changes only named requirement IDs and returns them to `Draft`.
   - `VALIDATE` performs an explicit read-only audit; MUST READ `assets/validate.md`.
7. MUST READ `assets/authority-and-status.md` before approval or handoff.
8. Run postflight. Create only linked handoff records for approved requirements.

## Output contract

Requirements use the compact template in `templates/requirements.md`. Each unit has a stable ID,
source, owner, status, one behavior statement, assumptions or open questions, and observable acceptance
criteria. Draft at most the manifest batch limit.

## Expected workspace

```text
requirements-<project>/
├── Harness/
├── Inputs/
├── Analysis/
└── Outputs/
```

The harness owns the complete workspace. Raw inputs are never edited. Current requirements live in
`Outputs/requirements.md`; explicit validation writes only `Analysis/validation-report.md`.
