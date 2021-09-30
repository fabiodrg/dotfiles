# Network configuration

## DNS providers and DNS over TLS

At this moment, the script just configures DNS by setting a list of DNS providers I "trust" and by enabling *DNS-Over-TLS* as well as *DNSSEC* (DNS Security Extensions).

The DNS configuration file, `resolved.conf`, is for `systemd.resolved` service, a network name resolution service for local applications.

- DNS providers can be configured in the *DNS* and *DNSFallback* fields. For now, my providers are: Cloudflare (`1.1.1.1` and `1.0.0.1`), IBM Quad9 (`9.9.9.9`) and Google (`8.8.8.8`).
- IPv6 DNS addresses are supported as well, but for now I am sticking to IPv4.
- One important note: all DNS providers I picked support DNS over TLS, DNSSEC and DNS over HTTPS (altough the latter is not relevant for this configuration). Therefore, I am able to fully enable `DNSOverTLS` and `DNSSEC`, using the stricter `yes` option, i.e. all DNS requests use TLS and DNSSEC. It's possible to set these fields with less-strict options where first DNS over TLS is attempted, but if it fails, the request is repeated without TLS (this is vulnerable to downgrade attacks tho).

### Testing configuration

- Check if global DNS configuration is correct: `$ resolvectl status`
- Attempt to resolve an address: `$ resolvectl query <address>`
- Use Wireshark. If the secure DNS is properly enabled, all queries go through the port 853. Without TLS, queries pass through port 53.

Note: Might be a good idea to flush the DNS cache for debugging purposes: `# resolvectl flush-caches`.

In my case, running Fedora, configuring `systemd.resolved` was enough. However, `NetworkManager` configurations may interfere. For example, if there are custom DNS per network connections. Or if the network manager is configured to override the global configuration set on `systemd.resolved`.

### References

- https://www.freedesktop.org/software/systemd/man/systemd-resolved.service.html
- https://www.man7.org/linux/man-pages/man5/resolved.conf.5.html
