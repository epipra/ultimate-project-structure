---
name: deploy
description: Deploy this project to its target environment. Use when the user asks to deploy, ship, or push a release.
---

# Deploy

1. Read `deploy-config.md` in this folder for target, build command, and environment details.
2. Run the project's build/test commands and confirm they pass.
3. Run the deploy command for the configured target.
4. Verify the deploy succeeded (health check URL, smoke test, or log tail).
5. Report what was deployed and where.
