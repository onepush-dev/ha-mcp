# HA-MCP on Railway: the official upstream image (homeassistant-ai/ha-mcp v9.2.0, MIT), app unmodified.
# Runs the OAuth-protected HTTP server (`ha-mcp-oauth`): your Home Assistant URL is fixed server-side and
# each user signs in with their own Home Assistant long-lived token on the consent page.
# This layer only: port 8080, unauthenticated /healthz for Railway, and ownership fix for the Railway
# volume at /home/mcpuser/.ha-mcp (OAuth client registrations + HMAC secret) before dropping to uid 999.
FROM ghcr.io/homeassistant-ai/ha-mcp:9.2.0
LABEL org.opencontainers.image.source="https://github.com/onepush-dev/ha-mcp"
USER root
COPY railway/start.sh /opt/railway/start.sh
RUN chmod 755 /opt/railway/start.sh && command -v setpriv
ENV MCP_PORT=8080 \
    MCP_HOST=0.0.0.0 \
    MCP_HEALTHZ=true
EXPOSE 8080
ENTRYPOINT ["/opt/railway/start.sh"]
CMD ["ha-mcp-oauth"]
