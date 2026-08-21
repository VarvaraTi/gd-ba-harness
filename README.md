# gd-ba-harness

Compact BA harness for creating, updating, and validating traceable requirements. It keeps scope bounded, records sources and assumptions, and requires human approval.

## Install

### Codex

Install this repository as a Codex Git marketplace, then install the plugin:

```text
codex plugin marketplace add VarvaraTi/gd-ba-harness --ref main
codex plugin add gd-ba-harness@gd-ba-harness-marketplace
```

Start a new Codex thread and explicitly ask it to use `gd-ba-harness` for your requirement task.

Updates are not automatic. After a new release, refresh the marketplace and reinstall the plugin:

```text
codex plugin marketplace upgrade gd-ba-harness-marketplace
codex plugin add gd-ba-harness@gd-ba-harness-marketplace
```

### ChatGPT desktop app

**Plugins → + → Add marketplace → Add from repository**, then enter:

```text
https://github.com/VarvaraTi/gd-ba-harness
```

Install `gd-ba-harness`, then start a new chat and select it from the Plugins Directory. In Codex,
invoke `$gd-ba-harness`.

### Claude Cowork

**Customize → Plugins → + → Add marketplace → Add from repository**, then enter:

```text
https://github.com/VarvaraTi/gd-ba-harness
```

Install `gd-ba-harness`, open a new session, and invoke `/gd-ba-harness`.

### Claude Code

```text
/plugin marketplace add VarvaraTi/gd-ba-harness
/plugin install gd-ba-harness@gd-ba-harness-marketplace
```

Run `/reload-plugins` if prompted, then invoke:

```text
/gd-ba-harness:gd-ba-harness
```

Jira and Confluence comparisons require separately configured read-only connectors/MCP servers.

## Analyst workflow

1. Describe one change in chat or provide selected files, Jira issues, and Confluence pages.
2. Confirm the proposed project, sources, owner, scope, limits, and output (the run manifest).
3. Answer focused questions. Unresolved blockers remain `Draft`.
4. Approve, defer, reject, or request changes for each drafted requirement.
5. Run `VALIDATE` before handoff when an independent review is needed.

Example:

```text
/gd-ba-harness

Project: PAYMENTS.
Create feature PAY-123: saved payment methods.
Users need to save a card, reuse it, and remove it.
Product owner: Anna Novak.
Use this message and Jira PAY-123 as read-only sources.
```

## Modes

- `INITIAL`: creates a bounded requirement set.
- `UPDATE`: changes selected requirement IDs, returns them to `Draft`, and requires reapproval.
- `VALIDATE`: read-only audit for duplicates, conflicts, sources, assumptions, testability, and criteria. Fix findings through `UPDATE`.

## Knowledge layout

The profile selects one strategy:

- `managed`: one authoritative `features/<id>/FEATURE.md` per feature.
- `existing`: map approved existing project locations without moving files.
- `minimal`: use `Harness/Inputs/Analysis/Outputs` for temporary or small work.

Managed projects use:

```text
features/
├── INDEX.md
├── STATUS.md
└── PAY-123-saved-payment-method/
    ├── FEATURE.md
    ├── STATUS.md
    ├── inputs/
    ├── analysis/
    ├── decisions/
    ├── evidence/
    └── scratch/
```

`FEATURE.md` is the authoritative specification. `STATUS.md` is mutable delivery state. `scratch/` is never authoritative or retrieved by default.

Before creating a managed feature, the harness searches `features/INDEX.md`. Exact duplicates reuse the existing feature; overlaps require a product-owner decision.

## Limits

Default run limits: one change, five sources, 10,000 lines, two rounds of five questions, and 15 drafted requirements. Work exceeding a limit is split rather than silently reduced.

Jira and Confluence are read-only. AI cannot approve scope or invent missing decisions.

## Development

```sh
make test
make build
```

`make build` creates `dist/gd-ba-harness.skill` with one top-level folder and `SKILL.md` directly inside it. The Codex and Claude distributions share the canonical skill source at `plugins/gd-ba-harness/skills/gd-ba-harness/`.

For each Codex release, update the `version` in `plugins/gd-ba-harness/.codex-plugin/plugin.json` before pushing the change. Users can then run the update commands above.
