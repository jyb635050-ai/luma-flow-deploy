#!/bin/sh
set -eu
export PUBLIC_BASE_URL="${PUBLIC_BASE_URL:-${RENDER_EXTERNAL_URL:?Render URL is required}}"
export ALLOWED_ORIGINS="${ALLOWED_ORIGINS:-$PUBLIC_BASE_URL}"
exec /app/luma-server "$@"
