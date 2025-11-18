FROM ubuntu:noble

# renovate: suite=noble depName=unbound
ARG UNBOUND_VERSION="1.19.2-1ubuntu3.5"

# renovate: suite=noble depName=openssl
ARG OPENSSL_VERSION="3.0.13-0ubuntu3.6"

# renovate: suite=noble depName=ca-certificates
ARG CA_CERTIFICATES_VERSION="20240203"

# renovate: suite=noble depName=bind9-dnsutils
ARG BIND9_DNSUTILS_VERSION="1:9.18.39-0ubuntu0.24.04.2"

RUN apt-get update && apt-get install -y \\
    unbound="${UNBOUND_VERSION}" \\
    openssl="${OPENSSL_VERSION}" \\
    ca-certificates="${CA_CERTIFICATES_VERSION}" \\
    && apt-get install -y --no-install-recommends \\
    bind9-dnsutils="${BIND9_DNSUTILS_VERSION}" \\
    && apt-get clean && rm -rf /var/lib/apt/lists/*

HEALTHCHECK --interval=5s --timeout=1s --retries=3 CMD unbound-control status || exit 1

CMD [ "/usr/sbin/unbound", "-d", "-p", "-c", "/etc/unbound/unbound.conf" ]
