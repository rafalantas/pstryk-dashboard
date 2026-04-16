FROM nginx:1.27-alpine

# Instaluj gettext dla envsubst
RUN apk add --no-cache gettext

# Skopiuj pliki www
COPY www/ /usr/share/nginx/html/

# Skopiuj konfigurację nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Skopiuj skrypt startowy
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80

# entrypoint wstrzykuje zmienne ENV do env.js przed uruchomieniem nginx
ENTRYPOINT ["/entrypoint.sh"]
