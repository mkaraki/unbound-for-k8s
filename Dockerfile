FROM debian:trixie-slim

# renovate: suite=noble depName=unbound
ARG UNBOUND_VERSION="1.22.0-1"

# renovate: suite=noble depName=openssl
ARG OPENSSL_VERSION="3.5.4-1~deb13u1"

# renovate: suite=noble depName=ca-certificates
ARG CA_CERTIFICATES_VERSION="20250419"

# renovate: suite=noble depName=bind9-dnsutils
ARG BIND9_DNSUTILS_VERSION="1:9.20.15-1~deb13u1"

RUN apt-get update && apt-get install -y \
    unbound="${UNBOUND_VERSION}" \
    openssl="${OPENSSL_VERSION}" \
    ca-certificates="${CA_CERTIFICATES_VERSION}" \
    && apt-get install -y --no-install-recommends \
    bind9-dnsutils="${BIND9_DNSUTILS_VERSION}" \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=5s --timeout=1s --retries=3 CMD unbound-control status || exit 1

CMD [ "/usr/sbin/unbound", "-d", "-p", "-c", "/etc/unbound/unbound.conf" ]
