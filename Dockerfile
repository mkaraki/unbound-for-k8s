FROM ubuntu:noble

RUN apt-get update && apt-get install -y unbound openssl ca-certificates && apt-get install -y --no-install-recommends bind9-dnsutils && apt-get clean && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=5s --timeout=1s --retries=3 CMD unbound-control status || exit 1

CMD [ "/usr/sbin/unbound", "-d", "-p", "-c", "/etc/unbound/unbound.conf" ]
