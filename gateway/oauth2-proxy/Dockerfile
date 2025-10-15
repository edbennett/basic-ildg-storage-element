FROM alpine:3.22.2
ADD https://github.com/oauth2-proxy/oauth2-proxy/releases/download/v7.12.0/oauth2-proxy-v7.12.0.linux-amd64.tar.gz /tmp/oap.tar.gz
RUN tar x -C /tmp -f /tmp/oap.tar.gz
RUN mv /tmp/oauth2-proxy-v7.12.0.linux-amd64/oauth2-proxy /usr/bin/
RUN apk add --no-cache bash
ENTRYPOINT ["oauth2-proxy"]
