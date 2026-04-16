#!/bin/sh
set -e

# Domyślne wartości jeśli zmienne nie są ustawione
: "${PSTRYK_API_KEY:=}"
: "${PSTRYK_METER_IP:=}"
: "${PSTRYK_METER_PORT:=80}"

echo "[pstryk-dashboard] Wstrzykiwanie zmiennych środowiskowych..."
echo "  PSTRYK_API_KEY:    $([ -n "$PSTRYK_API_KEY" ] && echo '[ustawiony]' || echo '[brak]')"
echo "  PSTRYK_METER_IP:   ${PSTRYK_METER_IP:-[brak]}"
echo "  PSTRYK_METER_PORT: ${PSTRYK_METER_PORT}"

# Wygeneruj env.js z template'u zastępując zmienne ENV
envsubst '${PSTRYK_API_KEY} ${PSTRYK_METER_IP} ${PSTRYK_METER_PORT}' \
  < /usr/share/nginx/html/env.js.template \
  > /usr/share/nginx/html/env.js

echo "[pstryk-dashboard] env.js wygenerowany. Uruchamiam nginx..."

exec nginx -g 'daemon off;'
