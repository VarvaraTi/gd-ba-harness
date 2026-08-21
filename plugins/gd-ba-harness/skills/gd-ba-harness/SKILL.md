---
name: gd-ba-harness
description: "Creates, updates, and validates bounded software requirements from chat, files, and authorized read-only project sources. Use explicitly for fast governed BA work with source traceability and human approval."
version: 0.3.0
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
2. MUST READ `assets/knowledge-organization.md` and load the project's knowledge strategy.
3. MUST READ `assets/preflight-postflight.md` before and after every run.
4. MUST READ `assets/connector-contracts.md` before using Jira or Confluence.
5. Load the project's `Harness/project-profile.yaml` and `Harness/source-registry.yaml`.
6. Resolve the active feature. In managed mode, run the duplicate-feature gate before creating one.
7. Propose a mode and a run manifest. Require the user to confirm both.
8. MUST READ `assets/requirements-lite.md`, then run exactly one enabled mode:
   - `INITIAL` creates a new bounded requirement set.
   - `UPDATE` changes only named requirement IDs and returns them to `Draft`.
   - `VALIDATE` performs an explicit read-only audit; MUST READ `assets/validate.md`.
9. MUST READ `assets/authority-and-status.md` before approval or handoff.
10. Run postflight. Create only linked handoff records for approved requirements.

## Output contract

In `managed` mode, requirements belong only in the active feature's `FEATURE.md`, using
`templates/FEATURE.md`. In `existing` and `minimal` modes, use the approved mapped or legacy
requirements path. Each unit has a stable ID, source, owner, status, one behavior statement,
assumptions or open questions, and observable acceptance criteria. Draft at most the manifest batch limit.

## Expected workspace

```text
requirements-<project>/
├── Harness/
├── .claude/rules/             # managed only
├── docs/                      # managed only
├── features/                  # managed only
├── Inputs/                    # minimal or mapped existing
├── Analysis/                  # minimal or mapped existing
└── Outputs/                   # minimal or mapped existing
```

The harness owns its configuration and feature workflow, not unrelated project files. Raw inputs are never
edited. In managed mode, `FEATURE.md` is authoritative and validation writes to the feature `analysis/`
directory; in minimal mode, use `Outputs/requirements.md` and `Analysis/validation-report.md`.
