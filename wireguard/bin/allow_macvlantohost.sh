#!/bin/bash

set -x


INT_NAME=mcvlan-link
HOST_INTERFACE=enp1s0

# macvlan parent interface
HOST_IP=192.168.42.10

# Containers using macvlans ...
# To check: is it required to add the route when on the same network ?
# Todo, must accept other IPs in case of many services ...
HOST_DEST=192.168.43.20/32
#HOST_DEST=192.168.42.100/28

main_up ()
{
  echo "INFO: Bring up interface $INT_NAME"
  # Let's do it
  ip link add $INT_NAME link $HOST_INTERFACE type macvlan mode bridge
  ip addr add $HOST_IP/32 dev $INT_NAME
  ip link set $INT_NAME up
  ip route add $HOST_DEST dev $INT_NAME
}

main_down ()
{
  echo "INFO: Bring down interface $INT_NAME"
  # Let's do it

  ip route del $HOST_DEST dev $INT_NAME
  ip link set $INT_NAME down
  ip addr del $HOST_IP/32 dev $INT_NAME
  ip link del $INT_NAME link $HOST_INTERFACE type macvlan mode bridge
}

main ()
{
  local arg=$1

  case "$arg" in
    up) main_up;;
    down) main_down;;
    *)
      echo "ERROR: Must use up or down"
      ;;
  esac
}


main ${@-}
