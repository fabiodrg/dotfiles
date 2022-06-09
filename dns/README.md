# Configuring the DNS servers

My host machine, running Fedora, uses `NetworkManager` [1] as the default management system for network connections. Other options exist and this configuration setup may no longer apply [2].

Besides, the system has `systemd` and `systemd-resolved` is already installed and enabled. There are no explicit configurations, but by default when `NetworkManager` detects that ` /etc/resolv.conf` is a symbolic link to `/run/systemd/resolve/stub-resolv.conf` (in my case), it lets `systemd-resolved` manage the DNS servers and pushes any configuration through it. Otherwise, the `NetworkManager` itself would edit the `/etc/resolv.conf`.

Note that `/etc/resolv.conf` is the main source for DNS servers in Linux. Resolver routines read the configuration file to find IPs for DNS servers, including `glibc`. Other application may also read the configuration file directly [3]. 

Problem: When establishing an internet connection, e.g. my home network, the DHCP client may push DNS servers. In case of a home network, tipically the ISP DNS is added. When connecting to VPNs, the same may happen. My goal is to centralize DNS management on `systemd-resolved`, and only use the DNS servers I explicitly provide.

Therefore, I want to configure `NetworkManager` to never touch `/etc/resolv.conf` (which is the default in my cause to the symlink), but also never suggest/push DNS servers to `systemd-resolved` per connection basis or `NetworkManager` configuration files (which allow for setting global DNS servers that apply on all connections). One key advantage in using `systemd-resolved` is that it supports caching. Besides, I dont think `NetworkManager` has DNS-over-TLS.

Extra: It is a good idea to have a single service responsible to maintain `/etc/resolv.conf`. It might be a good idea to make the file write-protect [4] to prevent other applications from breaking the configuration.

## Configuring `NetworkManager`

- Configuration options: https://man.archlinux.org/man/NetworkManager.conf.5
- Default configuration file is `/etc/NetworkManager/NetworkManager.conf`
- I tend to leave global or defaults intact. In this case, I can add custom config files under `/etc/NetworkManager/conf.d/`
- Docs add another important argument:
> If a default NetworkManager.conf is provided by your distribution's packages, you should not modify it, since your changes may get overwritten by package updates. Instead, you can add additional .conf files to the /etc/NetworkManager/conf.d directory.

- After reading the docs, all I have to do is:
    - Setting `dns=none`, which also implies `rc-manager=unmanaged`, and therefore the `NetworkManager` won't modify the `/etc/resolv.conf`
    - However, there's an complementary setting `systemd-resolved`. If `true`, it will push DNS configurations to `systemd-resolved`, for example when I connect to my home network it would push the ISP DNS. Thus, I want it `false`
        - To be honest, even when this is true, Wireshark does not log any request to my ISP DNS, but rather to the first DNS option I set in `systemd-resolved` (how is covered next). But, the configuration would list my ISP DNS. I suppose the resolver first tries global DNS servers I configured, and if all fail it would try per-connection DNS settings that are pushed by `NetworkManager`?

## Adding the DNS servers with `systemd-resolved`

- Man: https://man.archlinux.org/man/resolved.conf.5
- Main config file at `/etc/systemd/resolved.conf`
- Following the same principle as before, my config files will be placed at `/etc/systemd/resolved.conf.d/`
- The options to look into are:
    - `DNS`: the actual list of DNS servers IPv4 or IPv6 addresses ; can be set per network interface name
    - `FallbackDNS`
    - `Domains`: if the set to `~.`, the root DNS configuration is used for all domains 
    - `DNSSEC`
    - `DNSOverTLS`

### Testing configuration

- Check if global DNS configuration is correct: `$ resolvectl status`
- Attempt to resolve an address: `$ resolvectl query <address>`
- Use Wireshark. If the secure DNS is properly enabled, all queries go through the port 853. Without TLS, queries pass through port 53.

Note: Might be a good idea to flush the DNS cache for debugging purposes: `# resolvectl flush-caches`.

In my case, running Fedora, configuring `systemd.resolved` was enough. However, `NetworkManager` configurations may interfere. For example, if there are custom DNS per network connections. Or if the network manager is configured to override the global configuration set on `systemd.resolved`.

### References

1. https://wiki.archlinux.org/title/NetworkManager
2. https://wiki.archlinux.org/title/Network_configuration#Network_managers
3. https://wiki.archlinux.org/title/Domain_name_resolution
4. https://wiki.archlinux.org/title/Domain_name_resolution#Overwriting_of_/etc/resolv.conf

---

Old

## DNS providers and DNS over TLS

At this moment, the script just configures DNS by setting a list of DNS providers I "trust" and by enabling *DNS-Over-TLS* as well as *DNSSEC* (DNS Security Extensions).

The DNS configuration file, `resolved.conf`, is for `systemd.resolved` service, a network name resolution service for local applications.

- DNS providers can be configured in the *DNS* and *DNSFallback* fields. For now, my providers are: Cloudflare (`1.1.1.1` and `1.0.0.1`), IBM Quad9 (`9.9.9.9`) and Google (`8.8.8.8`).
- IPv6 DNS addresses are supported as well, but for now I am sticking to IPv4.
- One important note: all DNS providers I picked support DNS over TLS, DNSSEC and DNS over HTTPS (altough the latter is not relevant for this configuration). Therefore, I am able to fully enable `DNSOverTLS` and `DNSSEC`, using the stricter `yes` option, i.e. all DNS requests use TLS and DNSSEC. It's possible to set these fields with less-strict options where first DNS over TLS is attempted, but if it fails, the request is repeated without TLS (this is vulnerable to downgrade attacks tho).
