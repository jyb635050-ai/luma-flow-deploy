# Luma · 流光 deployment assets

Public build recipe and compiled browser assets for the Luma screen-sharing site.

The Docker build fetches the MIT-licensed Piik server directly from its public upstream at the fixed revision `390e637d4e9090e6258ccc3d3a0a3f877d81b25c`, embeds the compiled Luma browser assets in `web/`, and starts the resulting server as a non-root user. Original and third-party notices are retained.

This package contains no site credentials, room databases, or private project source. Source attribution: https://github.com/TNTcraftHIM/Piik.

Deploy using Render Free, Docker runtime, root `Dockerfile`, and the environment in `render.yaml`. The startup script reads the assigned `RENDER_EXTERNAL_URL`. This P2P-only configuration uses in-memory rooms; restarts retire invitations. Render Free can sleep when idle.
