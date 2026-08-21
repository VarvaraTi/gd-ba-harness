# Preflight and postflight

## Preflight

Create `Harness/runs/<run-id>.yaml` and verify:

1. The requested outcome, mode, knowledge strategy, active feature or mapped requirement path, owner, and downstream consumer.
2. The selected mode is one of `INITIAL`, `UPDATE`, or `VALIDATE`.
3. The source registry's authority, freshness, classification, and access rules.
4. The exact permitted source set and any denied access. Register chat input as `CHAT-<run-id>`.
5. Source count and total lines, change count, question and draft budgets, and split behavior.
6. Blocking decisions, conflicts, assumptions, and specialist routes.
7. For managed `INITIAL`, duplicate-feature disposition, active-feature count, and owner decision for any overlap.
8. The authoritative specification path and its baseline hash. Record `FEATURE.md` in managed mode.
9. Expected outputs, acceptance evidence, and stopping conditions.

Present the manifest for user confirmation. Do not begin requirements work before confirmation.

## Postflight

Compare actual artifacts and retrieved sources against the run manifest. Block handoff if:

- required artifacts or validation evidence are absent;
- actual sources, questions, requirement count, or changed IDs exceeded the manifest;
- a managed run created a second authoritative requirement file or changed `FEATURE.md` outside `UPDATE`;
- `VALIDATE` changed the authoritative specification, feature index, or handoff record;
- a required duplicate-check disposition or feature-index regeneration is absent;
- a blocking question, conflict, or unauthorized source is present;
- an approval is unnamed or model-generated;
- scope changed without approval; or
- the selected mode permitted no writes but outputs changed.

Create a handoff record that links to the exact authoritative specification version and evidence. Do not duplicate requirements.

For managed features, update only mutable lifecycle fields in `STATUS.md`. At feature handoff or closure,
extract approved decisions/evidence from `scratch/` and archive or delete the remaining temporary material
under the retention policy.
