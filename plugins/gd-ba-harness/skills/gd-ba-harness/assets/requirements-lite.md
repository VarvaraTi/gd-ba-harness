# Requirements Lite

Run only after the user confirms the mode and run manifest.

## Shared rules

- Work on one bounded change.
- Resolve the feature path from the approved knowledge strategy before reading or writing requirements.
- In `managed` mode, `FEATURE.md` is the sole authoritative feature specification. Do not create or maintain a duplicate `Outputs/requirements.md`.
- Read only manifest-approved sources. A chat statement is evidence named `CHAT-<run-id>`.
- Separate facts, human decisions, assumptions, open questions, and recommendations.
- Ask only questions whose answers can change scope, behavior, risk, or acceptance.
- Use at most the configured questions per round and rounds per run.
- If a blocking answer remains unknown, keep the affected unit `Draft`.
- One requirement contains one observable behavior. Use common domain language.
- Criteria describe normal, boundary, and important failure behavior using EARS-style `When/If ... the system shall ...`.
- Check targeted NFR concerns based on risk: security/privacy, performance, availability/recovery, accessibility, auditability, and compatibility. Do not perform an exhaustive standards sweep.

## INITIAL

1. For managed projects, search the feature index and inspect candidate feature specs before creating a new feature.
2. If an exact duplicate exists, reuse it and route to `UPDATE` or `VALIDATE`. If scope overlaps, stop for a product-owner decision.
3. Check the configured in-progress feature limit before creating a new active feature.
4. Create the managed feature folder, metadata, `FEATURE.md`, and `STATUS.md` only after the duplicate and limit checks pass.
5. Restate intent, in-scope outcome, non-goals, actors, and selected sources.
6. Detect direct conflicts and missing blocking decisions in that bounded context.
7. Ask a prioritized question round. After each answer, update understanding before asking more.
8. Stop questioning when the configured rounds are exhausted or no material unknown remains.
9. Draft no more than the configured requirement batch limit in the active feature spec or mapped legacy path.
10. Present a compact review grouped by requirement ID. The named owner explicitly approves, requests changes, defers, or rejects each unit.
11. Change only explicitly approved units to `Approved`. Keep all others `Draft` or mark rejected units `Removed` with a reason.
12. Regenerate the managed feature index after approved identity metadata changes.

## UPDATE

1. Require the active feature and affected requirement IDs. If they are unknown, locate candidates and ask the user to confirm them.
2. Load only those units, their linked sources, dependencies, and affected criteria.
3. Show the proposed change boundary and downstream evidence that may become stale.
4. Return changed units to `Draft`; preserve their IDs.
5. Ask only change-specific questions, apply the bounded drafting rules, and require reapproval.
6. Do not rewrite unaffected units.
7. Update mutable delivery state in `STATUS.md`, not requirement meaning.

## Split behavior

If any configured limit is exceeded, stop before drafting. Report the exceeded limit and propose a MECE split by capability, actor journey, or independent outcome. The user selects one scope for the current run.
