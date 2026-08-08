# Authority, status, and handoff

## Authority

The approved requirement set is authoritative for product requirements. It does not override policies, architecture decisions, delivery state, or operational records owned elsewhere.

Raw evidence, derived summaries, and AI output remain non-authoritative until the named accountable owner approves a linked decision or requirement.

## Status mapping

Requirement units use `Draft`, `Approved`, and `Removed`. Track `proposed`, `disputed`, `stale`, and `superseded` in the surrounding decision, source, and handoff records.

Do not include unresolved or stale material in an approved handoff as settled guidance.

## Handoff

Handoff requires:

- named requirement-set version;
- approved requirements and EARS criteria;
- source and decision links;
- open non-blocking assumptions and risks;
- named specialist reviews where applicable; and
- a downstream destination.

Any semantic requirement change invalidates affected handoff evidence and must run through `UPDATE`.
