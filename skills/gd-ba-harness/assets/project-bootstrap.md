# Project bootstrap

Create a workspace only after the user approves its location and project profile.

## Required profile fields

- `project.id`, `project.name`, and `project.requirements_workspace`
- named intent and product-scope owners
- source registry location
- data classification and raw-evidence retention rule
- enabled connector scopes
- default risk tier and protected topics
- engineering and independent-testing handoff destinations

## Bootstrap steps

1. Create `Harness/`, `Inputs/`, `Analysis/`, and `Outputs/`.
2. Copy the project profile, source registry, and run manifest templates into `Harness/`.
3. Inspect the project and propose one knowledge strategy:
   - `managed` for a new project that accepts the feature-oriented layout;
   - `existing` when authoritative project locations already exist;
   - `minimal` for small or temporary work.
4. Require the user to confirm the strategy and path mappings. Never move or reorganize existing files silently.
5. For `managed`, create only missing `.claude/rules/`, `docs/{architecture,business-processes,contracts,patterns,templates}/`, `features/`, `features/INDEX.md`, and `features/STATUS.md` from the templates.
6. Copy `FEATURE.md` and feature-status templates only when creating a managed feature. Copy the legacy requirements template to `Outputs/requirements.md` only for `minimal` or an approved `existing` mapping.
7. Create an empty source registry; do not treat it as proof that sources do not exist.
8. Record missing owners, inaccessible sources, unconfirmed retention rules, and unclear layout authority as blockers.
9. Do not begin a requirements run until the profile, source registry, and knowledge strategy are approved.
