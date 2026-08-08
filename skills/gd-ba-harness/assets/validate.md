# Validate mode

Use `VALIDATE` to audit an existing requirement set without changing it.

## Preflight additions

- Record the requirement-set version, file list, and content hashes in the run manifest.
- Set expected output to `Analysis/validation-report.md`.
- Set all requirement, connector, and handoff write paths to denied.
- Name the reviewer and any people authorized to waive failed checks.

## Invocation

Use a fresh reviewer context that did not author the requirements. Give it only the requirement set,
approved intent, source registry, selected source evidence, and `templates/validation-report.md`.

Check:

- one behavior per requirement;
- clear actor/system response and observable acceptance criteria;
- source and owner present;
- assumptions and open questions not represented as facts;
- duplicate or conflicting behavior;
- targeted NFR gaps implied by the recorded risk;
- approval status supported by a named decision.

## Postflight additions

Confirm the requirement-set hashes are unchanged. If any requirement file, `Outputs/INDEX.md`, or handoff record changed, mark the run invalid.

The validation report must distinguish passed checks, findings, missing evidence, and waived checks. Each waiver needs a named owner and reason. A finding that requires a semantic change routes to `UPDATE`; `VALIDATE` never fixes it.
