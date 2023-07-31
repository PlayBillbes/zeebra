FROM alpine:edge
ENV USERNAME="modsbots" \
    PASSWORD="modsbots" \
    SUDO_OK="true" \
    AUTOLOGIN="false" \
    TZ="Etc/UTC"

COPY ./vss.sh /
COPY ./skel/ /etc/skel

RUN apk update && \
    apk add --no-cache tini bash ttyd tzdata sudo nano && \
    chmod 700 /vss.sh && \
    touch /etc/.firstrun && \
    ln -s "/usr/share/zoneinfo/$TZ" /etc/localtime && \
    echo $TZ > /etc/timezone 

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/run.sh"]

EXPOSE 80
