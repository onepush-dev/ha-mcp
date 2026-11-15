# HA-MCP on Railway

[HA-MCP](https://github.com/homeassistant-ai/ha-mcp) (MIT) — an MCP server with 86 tools that lets Claude, ChatGPT and other AI assistants search, control, configure and automate your Home Assistant. This template runs it as an always-on HTTPS server with **OAuth sign-in**: each user authorizes with their own Home Assistant long-lived access token. Deploy on Railway with one click.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/TEMPLATE_CODE)

## What this template runs

- One service from `ghcr.io/onepush-dev/ha-mcp:9.2.0`: the official `ghcr.io/homeassistant-ai/ha-mcp:9.2.0` image, app unmodified, started as `ha-mcp-oauth`.
- Public HTTPS domain on port 8080; MCP endpoint `/mcp`; healthcheck `/healthz`; restart policy Always.
- One volume at `/home/mcpuser/.ha-mcp`: OAuth client registrations and the HMAC secret (so sign-ins survive restarts) plus settings.

## Variables

| Variable | Value | Notes |
|---|---|---|
| `HOMEASSISTANT_URL` | **you enter it** | Your Home Assistant URL, reachable from the internet (Nabu Casa remote URL, Cloudflare Tunnel, reverse proxy...). |
| `MCP_BASE_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` | Public URL of this server, used in OAuth metadata. Change it if you add a custom domain. |
| `MCP_SETTINGS_SECRET_PATH` | `/private_<generated>` | Secret path of the web settings page. |

Baked into the image: `MCP_PORT=8080`, `MCP_HOST=0.0.0.0`, `MCP_HEALTHZ=true`.

## Connect

1. In Home Assistant: Profile → Security → Long-lived access tokens → Create token (an admin user's token is recommended).
2. In Claude.ai: Settings → Connectors → Add custom connector → URL `https://<your-domain>/mcp`. Claude registers itself over OAuth.
3. On the consent page, paste your Home Assistant token and Authorize.

Any MCP client with OAuth support (Claude Code, ChatGPT connectors, ...) works the same way.

## Notes

- Home Assistant must be reachable from Railway; a `homeassistant.local` address on your LAN will not work.
- Anyone who can reach the server still needs a valid Home Assistant token to do anything.
- Not affiliated with Home Assistant or the Open Home Foundation.
