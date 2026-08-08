# Requirements Lite

Run only after the user confirms the mode and run manifest.

## Shared rules

- Work on one bounded change.
- Read only manifest-approved sources. A chat statement is evidence named `CHAT-<run-id>`.
- Separate facts, human decisions, assumptions, open questions, and recommendations.
- Ask only questions whose answers can change scope, behavior, risk, or acceptance.
- Use at most the configured questions per round and rounds per run.
- If a blocking answer remains unknown, keep the affected unit `Draft`.
- One requirement contains one observable behavior. Use common domain language.
- Criteria describe normal, boundary, and important failure behavior using EARS-style `When/If ... the system shall ...`.
- Check targeted NFR concerns based on risk: security/privacy, performance, availability/recovery, accessibility, auditability, and compatibility. Do not perform an exhaustive standards sweep.

## INITIAL

1. Restate intent, in-scope outcome, non-goals, actors, and selected sources.
2. Detect direct conflicts and missing blocking decisions in that bounded context.
3. Ask a prioritized question round. After each answer, update understanding before asking more.
4. Stop questioning when the configured rounds are exhausted or no material unknown remains.
5. Draft no more than the configured requirement batch limit in `Outputs/requirements.md`.
6. Present a compact review grouped by requirement ID. The named owner explicitly approves, requests changes, defers, or rejects each unit.
7. Change only explicitly approved units to `Approved`. Keep all others `Draft` or mark rejected units `Removed` with a reason.

## UPDATE

1. Require affected requirement IDs. If they are unknown, locate candidates and ask the user to confirm them.
2. Load only those units, their linked sources, dependencies, and affected criteria.
3. Show the proposed change boundary and downstream evidence that may become stale.
4. Return changed units to `Draft`; preserve their IDs.
5. Ask only change-specific questions, apply the bounded drafting rules, and require reapproval.
6. Do not rewrite unaffected units.

## Split behavior

If any configured limit is exceeded, stop before drafting. Report the exceeded limit and propose a MECE split by capability, actor journey, or independent outcome. The user selects one scope for the current run.
