#!/bin/sh
set -e
D=/home/mcpuser/.ha-mcp
mkdir -p "$D"
chown -R 999:999 "$D" 2>/dev/null || true
if [ -z "${MCP_BASE_URL:-}" ] && [ -n "${RAILWAY_PUBLIC_DOMAIN:-}" ]; then
  export MCP_BASE_URL="https://${RAILWAY_PUBLIC_DOMAIN}"
fi
case "${HOMEASSISTANT_URL:-}" in
  http://*|https://*) ;;
  *) echo "railway: set HOMEASSISTANT_URL to your Home Assistant URL (https://..., reachable from Railway)" >&2; exit 1;;
esac
echo "railway: HA-MCP OAuth server, MCP endpoint ${MCP_BASE_URL}${MCP_SECRET_PATH:-/mcp}, Home Assistant ${HOMEASSISTANT_URL}"
exec setpriv --reuid=999 --regid=999 --init-groups env HOME=/home/mcpuser "$@"
