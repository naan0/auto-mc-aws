FROM openjdk:8-jre-alpine

RUN apk update ; \
    apk add --no-cache wget curl ca-certificates jq ; \
    mkdir /ftb

COPY ftb_init.sh ftb_start.sh /
RUN chmod +x /ftb_init.sh /ftb_start.sh

VOLUME ["/world"]

WORKDIR /

ENTRYPOINT ["/bin/sh","/ftb_start.sh"]

EXPOSE 25565 25575
