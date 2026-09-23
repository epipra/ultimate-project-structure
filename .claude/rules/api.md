---
paths:
  - "src/api/**"
---

# API rules (loaded only when working in src/api/)

- Validate every request body and query param with a schema before use.
- Return the envelope `{ "success": bool, "data": ..., "error": string|null }`.
- Use parameterized queries only; never build SQL from strings.
- Every endpoint needs auth unless listed in `src/api/public.ts`.
- Never log tokens, passwords, or full request bodies.
- Paginate list endpoints (`limit` ≤ 100, default 20).
