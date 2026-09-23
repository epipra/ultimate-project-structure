# Deploy Config

Read by the `deploy` skill and the `/ship` command.

- Target: `<fill in — e.g. Vercel, Fly.io, VPS via SSH, Cloudflare Pages>`
- Environments: `<fill in — e.g. preview, production>`
- Build command: `<fill in>`
- Deploy command: `<fill in>`
- Health check URL: `<fill in>`
- Rollback command: `<fill in>`

Vercel projects can use the bundled plugin instead: `claude --plugin-dir .claude/plugins/vercel`, then `/vercel:deploy`.
