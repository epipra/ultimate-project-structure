---
description: Deploy to Vercel (preview by default, --prod for production)
argument-hint: "[--prod]"
allowed-tools: Bash
---

1. Check `vercel --version`; if missing, tell the user to run `npm i -g vercel` and stop.
2. Run `vercel deploy $ARGUMENTS --yes`.
3. Report the deployment URL and whether it is preview or production.
