FROM alpine:latest


RUN apk --no-cache add bind-tools ca-certificates dnssec-root dns-root-hints unbound


RUN rm -rf /etc/unbound/*

COPY ./include/unbound.sh /unbound.sh
COPY ./include/unbound.conf /etc/unbound/unbound.conf

RUN chmod +x /unbound.sh
RUN update-dns-root-hints


EXPOSE 53/tcp
EXPOSE 53/udp

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s --retries=3 CMD dig @127.0.0.1 || exit 1

ENTRYPOINT ["/unbound.sh"]
