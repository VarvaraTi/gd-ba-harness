# Preflight and postflight

## Preflight

Create `Harness/runs/<run-id>.yaml` and verify:

1. The requested outcome, mode, requirement workspace, owner, and downstream consumer.
2. The selected mode is one of `INITIAL`, `UPDATE`, or `VALIDATE`.
3. The source registry's authority, freshness, classification, and access rules.
4. The exact permitted source set and any denied access. Register chat input as `CHAT-<run-id>`.
5. Source count and total lines, change count, question and draft budgets, and split behavior.
6. Blocking decisions, conflicts, assumptions, and specialist routes.
7. Expected outputs, acceptance evidence, and stopping conditions.

Present the manifest for user confirmation. Do not begin requirements work before confirmation.

## Postflight

Compare actual artifacts and retrieved sources against the run manifest. Block handoff if:

- required artifacts or validation evidence are absent;
- actual sources, questions, requirement count, or changed IDs exceeded the manifest;
- a blocking question, conflict, or unauthorized source is present;
- an approval is unnamed or model-generated;
- scope changed without approval; or
- the selected mode permitted no writes but outputs changed.

Create a handoff record that links to the exact requirement-set version and evidence. Do not duplicate requirements.
