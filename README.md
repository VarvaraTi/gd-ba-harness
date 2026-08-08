# gd-ba-harness

Reusable Claude Cowork harness for fast, governed business-analysis requirements work.

It contains a compact requirements workflow with project profiles, source authority, bounded runs, read-only Jira and Confluence contracts, explicit approvals, and versioned handoffs. No other requirements skill is needed.

## What it is for

Use `gd-ba-harness` to turn a bounded business request into traceable software requirements without allowing AI to approve scope or invent missing decisions.

The harness can:

- create requirements from chat, files, and authorized read-only project sources;
- update selected requirement IDs without rewriting unrelated requirements;
- validate an existing requirement set against intent, sources, other requirements, and recorded risk;
- keep assumptions and unresolved questions visible;
- prepare approved requirements for engineering and independent testing.

## Analyst quick start

You do not need to clone a repository, run commands, edit YAML, or know the mode names.

### 1. Enable the plugin

1. Open Claude Cowork with your organization account.
2. Open **Customize → Plugins**.
3. In **Personal plugins**, click `+`.
4. Select **Add marketplace** → **Add from repository**.
5. Enter:
   ```text
   https://github.com/VarvaraTi/gd-ba-harness
   ```
   The `VarvaraTi/gd-ba-harness` shorthand also works.
6. Authorize GitHub access if Cowork requests it.
7. Wait for marketplace synchronization.
8. Find `gd-ba-harness` and click **Install**.
9. Start a new Cowork session and invoke `/gd-ba-harness`.

If Cowork cannot access the repository, connect the Claude GitHub App to `gd-ba-harness`. For an organization-managed installation, ask an Owner or Primary Owner to open **Organization settings → Plugins → Add plugin → GitHub**, enter `VarvaraTi/gd-ba-harness`, and assign the plugin to your team.

### Install in Claude Code or CLI

Inside an active Claude Code session:

```text
/plugin marketplace add VarvaraTi/gd-ba-harness
/plugin install gd-ba-harness@gd-ba-harness-marketplace
```

Run `/reload-plugins` if Claude Code requests it. Invoke the installed skill with:

```text
/gd-ba-harness:gd-ba-harness
```

From a terminal, install it for all your projects:

```sh
claude plugin marketplace add VarvaraTi/gd-ba-harness
claude plugin install gd-ba-harness@gd-ba-harness-marketplace --scope user
```

Use `--scope project` instead to limit the installation to the current project, or `--scope local` for an unshared local installation.

Jira and Confluence access in Claude Code requires separately configured MCP servers or connectors. Without them, the harness can use chat and local files but must stop any requested Jira or Confluence comparison.

### 2. Describe one change

Start with `/gd-ba-harness`, name the project, and explain the business need in your own words:

```text
/gd-ba-harness

Project: PAYMENTS.
We need users to save a payment method, reuse it for another payment,
and remove it from account settings.
Product owner: Anna Novak.
Use this message as the source.
```

You may also attach files or name specific read-only Jira issues and Confluence pages:

```text
/gd-ba-harness

Create requirements for project PAYMENTS from the attached discovery notes,
Jira PAY-123, and Confluence page "Saved payment methods".
Product owner: Anna Novak.
```

The plugin proposes the correct mode. You do not need to select one yourself.

### 3. Confirm the proposed run

Before writing requirements, the plugin shows a short run summary. Check:

- Is this the correct project and change?
- Are the permitted sources correct?
- Is the responsible owner named?
- Is the expected output correct?
- Are any important sources missing?

Reply `Confirm` to continue, or describe what must change. This confirmation is called approving the run manifest.

### 4. Answer focused questions

The plugin asks only questions that can materially change scope, behavior, risk, or acceptance. Answer what you know. Assign an owner or say `unknown` when somebody else must decide.

The plugin does not invent missing answers. A requirement with an unresolved blocking question remains `Draft`.

### 5. Review the requirements

For every requirement, respond with one decision:

```text
REQ-PAY-001: Approve
REQ-PAY-002: Request changes — guest users must be excluded
REQ-PAY-003: Defer — Legal must decide retention
REQ-PAY-004: Reject — outside this change
```

Only explicitly approved requirements become `Approved`. The current set is stored in `Outputs/requirements.md`.

### 6. Validate before handoff

Validation is a separate step so normal drafting remains fast:

```text
/gd-ba-harness

Validate the current PAYMENTS requirements.
Compare them with Jira PAY-123 and PAY-124.
Check duplicates, conflicts, missing sources, assumptions,
testability, and acceptance criteria.
Use Jira read-only.
```

Validation writes `Analysis/validation-report.md` and does not edit requirements. Use a later update request to fix findings.

### Existing projects

You can start with an existing project. Tell the plugin where current requirements are and which sources it may read:

```text
/gd-ba-harness

Use existing project PAYMENTS.
Current requirements are in Outputs/requirements.md.
Update REQ-PAY-003 using Jira PAY-123 and policy POL-12.
```

If project configuration is missing, the plugin proposes it and asks you to confirm it. The analyst should review the project name, owners, source access, and data classification; the plugin manages the workspace files.

## What happens behind the scenes

```text
Analyst request
→ bounded run proposal
→ analyst confirmation
→ focused questions
→ Draft requirements
→ analyst decisions
→ optional read-only validation
→ engineering/testing handoff
```

## Modes

### INITIAL

Creates a new bounded requirement set in `Outputs/requirements.md`.

```text
/gd-ba-harness
INITIAL for project PAYMENTS.
Users need to save a payment method, reuse it, and remove it.
Use this message as the only source.
```

Use it when no requirement set exists for the change. The chat message becomes named source evidence, not automatically approved scope.

### UPDATE

Changes only confirmed requirement IDs, preserves their IDs, returns changed units to Draft, and requires reapproval.

```text
/gd-ba-harness
UPDATE REQ-PAY-003.
Change retention from 30 to 90 days.
Use policy POL-12 and Jira PAY-123 as read-only sources.
```

Use it when approved requirement meaning or acceptance criteria must change.

### VALIDATE

Audits requirements in a fresh reviewer context and writes `Analysis/validation-report.md`. It must not change requirements or external systems.

```text
/gd-ba-harness
VALIDATE Outputs/requirements.md.
Compare it with Jira PAY-123 and PAY-124.
Check duplicates, conflicts, sources, assumptions, testability, and acceptance criteria.
Use Jira read-only.
```

Use it before handoff, after material changes, or when an independent quality review is needed. Corrections discovered by validation must be made later through `UPDATE`.

If Jira or Confluence access is unavailable, the harness stops and reports the missing connector rather than pretending that comparison was performed.

## Run manifest

A manifest is the approved contract for one run. It records:

- selected mode and project;
- permitted and denied sources;
- read-only connector scope;
- limits and stopping conditions;
- required approvals;
- expected output and downstream consumer.

Requirements work does not start until the user confirms it.

## Development

```sh
make test
make build
```

`make build` also checks that the `.skill` archive has exactly one top-level folder and that `SKILL.md` is directly inside it.

## Deliberate limitations

The lite workflow does not support `QUERY`, `REVERSE`, or `REFACTOR`; does not perform broad project discovery; and does not automatically run `VALIDATE` after authoring. Split larger changes into separate runs.

Each run is limited by default to one change, five sources, 10,000 source lines, two rounds of five questions, and 15 drafted requirements. Jira and Confluence are read-only. The plugin stops and proposes a split when the work is too large.

## For marketplace administrators

1. Publish this project to an approved private repository.
2. Give the Cowork organization integration read access.
3. Register `.claude-plugin/marketplace.json` as an organization marketplace source.
4. Subscribe the intended analysts or teams to `gd-ba-harness`.
5. Verify the analyst quick-start flow in a clean Cowork session.

Regular analysts receive installation and updates through the organization marketplace.
