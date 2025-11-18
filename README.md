# Debian version of unbound docker image

This Dockerfile will create [`unbound`](https://packages.ubuntu.com/noble/unbound) installed image with
[`openssl`](https://packages.ubuntu.com/noble/openssl),
[`ca-certificates`](https://packages.ubuntu.com/noble/ca-certificates) and
[`bind9-dnsutils`](https://packages.ubuntu.com/noble/bind9-dnsutils)
for some unbound features and advanced monitoring with k8s liveness probe and more.

## Docker healthcheck

By default, this image will check `remote-control` is active.

This feature requires [`/etc/unbound/unbound.conf.d/remote-control.conf`]
and default [`/etc/unbound/unbound.conf`] file.
If you want to change those files, please disable docker healthcheck.

[`/etc/unbound/unbound.conf.d/remote-control.conf`]: https://salsa.debian.org/dns-team/unbound/-/blob/f901ed603e2d67d85b46d22735fc7ad7b7b5846e/debian/unbound.conf.d/remote-control.conf
[`/etc/unbound/unbound.conf`]: https://salsa.debian.org/dns-team/unbound/-/blob/f901ed603e2d67d85b46d22735fc7ad7b7b5846e/debian/unbound.conf

## Kubernetes liveness probe

Here is a sample code of liveness probe configuration:

```yaml
livenessProbe:
  exec:
    command:
      - /bin/sh
      - -c
      - 'dig a.root-servers.net @127.0.0.1 && /usr/bin/[ `dig a.root-servers.net @127.0.0.1 +short | wc -l` -ge 1 ]'
  initialDelaySeconds: 15
  periodSeconds: 5
```
