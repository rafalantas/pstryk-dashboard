FROM nginx:1.27-alpine

RUN apk add --no-cache gettext

COPY www/ /usr/share/nginx/html/
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
