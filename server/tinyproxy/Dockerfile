FROM vimagick/tinyproxy
RUN apk add --no-cache gettext

ARG PROXY_USER
ARG PROXY_PASS

ENV PROXY_USER=$PROXY_USER
ENV PROXY_PASS=$PROXY_PASS

COPY tinyproxy.conf.template /etc/tinyproxy/tinyproxy.conf.template
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]