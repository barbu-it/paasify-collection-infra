# Wireguard


## Client setup

### Troubleshoot

Resolve resolvers issues:
```
resolvectl status
```

### Network Manager (GUI)

* Right click on Network Manager systray icon, select `Edit connections ...`. Create new Virtual
interface with Wireguard as protocol.
* Name your network, like: Company VPN
* Interface name should be set to: `wg0` (what about wg1 ?)
* In Wireguard tab,
    * Fill private key
    * The add new peer:
        * Fill Public Key, Allowed IPs, Endpoint and Preshared Key.
        * If you set `0.0.0.0/0` as allowed IPs, it will route all your traffic into the VPN by default
    * Then in the ipv4 tab:
        * Select `Manual` Method
        * Create a new IP address
            * Netmask should be: 255.255.255.255
            * Gateway should be: 0.0.0.0
        * Fill the DNS server if you want to use it (recommended if you allowed `0.0.0.0/0`)
            * You may want to have split DNS that start with a tilde `~`
            * You can add more than one domain by seprating them with comas.
            * Adding more than 3 domains may not be supported by your OS.
            * Example: `~company.net,~company.com`
    * Ensure the IPv6 is also disabled
* Save and you're good



### Network Manager (CLI)

Ensure you fetch your client config, and you pu it in a `wg0.conf` file. Name of the file is important, and you can increment the number if more than one config is required.
```
$ cat wg0.conf 

[Interface]
Address = 10.9.7.10
PrivateKey = ...
ListenPort = 51820
DNS = 10.9.1.1

[Peer]
PublicKey = ...
PresharedKey = ...
Endpoint = wg.example.com:51820
AllowedIPs = 0.0.0.0/0

```

Then add it in the command line, not sure why we need sudo in this case, but anyway:
```
$ sudo nmcli connection import type wireguard file wg0.conf 
[sudo] password for user: 
Connection 'wg0' (200a9a5d-e8ee-4ef2-aa3a-9640f74ab0ec) successfully added.
```

## Server setup

### Routing VPN

If you don't use Wireguard in NAT mode, you will have to add routes at differents parts of your infra, by starting with your docker host in case of single node docker. Usually, you will want to configure that on your home router.

Usage:
```
ip route add $wireguard_network/24 via $wireguard_internal_ip
```

Example:
```
ip route add 10.1.7.0/24 via 10.1.1.6
```


