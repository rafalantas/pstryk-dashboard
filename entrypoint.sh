#!/bin/sh
set -e

: "${PSTRYK_API_KEY:=}"
: "${PSTRYK_METER_IP:=192.168.1.182}"
: "${PSTRYK_METER_PORT:=80}"
: "${TZ:=Europe/Warsaw}"

echo "[pstryk] Wstrzykiwanie zmiennych środowiskowych..."
echo "  PSTRYK_API_KEY:    $([ -n "$PSTRYK_API_KEY" ] && echo '[ustawiony]' || echo '[brak]')"
echo "  PSTRYK_METER_IP:   ${PSTRYK_METER_IP}"
echo "  PSTRYK_METER_PORT: ${PSTRYK_METER_PORT}"
echo "  TZ:                ${TZ}"

envsubst '${PSTRYK_API_KEY} ${PSTRYK_METER_IP} ${PSTRYK_METER_PORT} ${TZ}' \
  < /usr/share/nginx/html/env.js.template \
  > /usr/share/nginx/html/env.js

envsubst '${PSTRYK_METER_IP} ${PSTRYK_METER_PORT}' \
  < /etc/nginx/conf.d/default.conf.template \
  > /etc/nginx/conf.d/default.conf

echo "[pstryk] Konfiguracja gotowa. Uruchamiam nginx..."
exec nginx -g 'daemon off;'
