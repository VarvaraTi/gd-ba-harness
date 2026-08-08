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
3. Copy the requirements template to `Outputs/requirements.md` only when starting `INITIAL`.
4. Create an empty source registry; do not treat it as proof that sources do not exist.
5. Record missing owners, inaccessible sources, and unconfirmed retention rules as blockers.
6. Do not begin a requirements run until the profile and source registry are approved.
