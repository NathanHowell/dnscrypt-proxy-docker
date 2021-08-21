# dnscrypt-proxy Docker image

This is a no-frills Docker image for [dnscrypt-proxy](https://github.com/DNSCrypt/dnscrypt-proxy).
The configuration is lightly modified from the supplied [example-dnscrypt-proxy.toml](https://github.com/DNSCrypt/dnscrypt-proxy/blob/master/dnscrypt-proxy/example-dnscrypt-proxy.toml):

```diff
42c42
< listen_addresses = ['127.0.0.1:53']
---
> listen_addresses = ['0.0.0.0:53']
55c55
< # user_name = 'nobody'
---
> user_name = 'nobody'
64c64
< ipv6_servers = false
---
> ipv6_servers = true
```

