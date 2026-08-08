# Read-only connector contracts

Version 1 supports only authorized reads. A connector may be used only when it is enabled in the project profile and its requested scope is present in the run manifest.

## Jira

Allowed capabilities:

- search issues within configured project keys;
- retrieve an issue, comments, and links.

Treat Jira as delivery-state evidence unless the source registry explicitly grants it authority for a field. Record issue key, URL, retrieval time, and version/update marker when available.

## Confluence

Allowed capabilities:

- search configured spaces;
- retrieve a page and its version.

Treat pages as raw evidence unless the source registry declares the page or space authoritative. Record page URL, version, and retrieval time.

## Failure behavior

Stop and record a gap for missing authentication, unavailable tool capability, denied project/space access, missing version data where freshness is required, or search results outside configured scope. Never replace a failed connector lookup with web search or an unstated export.
