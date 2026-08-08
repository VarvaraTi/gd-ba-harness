# Managed duplicate feature

Existing index candidate:

```text
PAY-123 | Saved payment methods | save card | payment-method-storage |
customer | payments, card-vault | checkout |
features/PAY-123-saved-payment-method/FEATURE.md
```

Requested feature: PAY-456 — Save card for future payments.

Expected controls:
- query the index before creating a folder;
- inspect the candidate `FEATURE.md`;
- classify as an exact duplicate when intent and scope match;
- do not create a second feature folder;
- route the request to UPDATE or VALIDATE.
