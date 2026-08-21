# Knowledge organization

Select one strategy in `Harness/project-profile.yaml`:

- `managed`: create and govern the feature-oriented layout.
- `existing`: use approved project path mappings; never move files automatically.
- `minimal`: use `Harness/`, `Inputs/`, `Analysis/`, and `Outputs/` for small or temporary work.

## Managed layout

```text
.claude/rules/              # AI-only rules and guardrails
docs/                       # durable, tool-neutral knowledge
Harness/                    # profile, registry, and run manifests
features/INDEX.md           # compact derived feature index
features/STATUS.md          # mutable project feature registry
features/<feature-id>/      # one bounded feature
```

Inside a feature:

- `FEATURE.md` is the authoritative intent, requirements, criteria, and feature identity.
- `STATUS.md` is mutable delivery state. It must not restate requirement meaning.
- `inputs/` contains immutable raw evidence.
- `analysis/` contains questions, conflict records, and validation reports.
- `decisions/` contains approved decision records.
- `evidence/` contains handoff and validation links.
- `scratch/` is temporary, non-authoritative working material.

## Frequency and authority

- `.claude/rules/`: very rarely changed, AI-specific instructions only.
- `docs/architecture/`, `docs/business-processes/`, `docs/contracts/`, and `docs/patterns/`: rarely changed governed project knowledge.
- Feature status records: frequently changed delivery state.

Do not put business, architecture, contract, or policy truth in `.claude/`.

## Retrieval

Read the active feature's `FEATURE.md`, its linked decisions, and manifest-approved sources first.
Load durable `docs/` material only when linked by the feature, source registry, or stated scope.
Never retrieve `scratch/` by default; use it only when a person explicitly selects it as evidence.

`features/INDEX.md` is a derived retrieval aid, not authority. It contains feature metadata only.
If it is missing or stale, broaden discovery and inspect candidate feature files; never infer that no match exists.

## Duplicate feature gate

Before creating a managed feature:

1. Search `features/INDEX.md` by tracker ID, aliases, capabilities, actors, systems, and scope tags.
2. Read only the returned candidate `FEATURE.md` files.
3. Classify each candidate as exact duplicate, overlap, related dependency, or new.

Exact duplicates reuse the existing feature and route to `UPDATE` or `VALIDATE`.
For overlap, stop and ask the product owner to merge, split, supersede, or define explicit boundaries.

## Scratch retirement

At feature handoff or closure, extract useful approved decisions and evidence from `scratch/`.
Delete or archive the remaining temporary material according to the project retention policy.
