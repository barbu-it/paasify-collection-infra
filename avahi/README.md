# Avahi


# Import notes

To allow avahi to work, you will want to use it on your lan, with the macvtap driver. This is because avahi need to broadcast to your lan network.


You may need to enable macvlan:
```
networks:
  lan:
    name: lan
    driver: macvlan
    driver_opts:
      parent: enp1s0
    ipam:
      config:
        # This should be your lan network
        - subnet: 192.168.42.0/24
          #- subnet: 192.168.42.144/28
          # 192.168.42.145 -> 192.168.42.158
          # 192.168.42.159

services:
  avahi:
    networks:
      lan:
        # This IP is outside my DNS range of my lan
        ipv4_address: 192.168.42.100

```
