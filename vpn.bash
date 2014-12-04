#!/bin/bash

# Adds routes to gw for network addressed defined in ~/.vpn.routes
# Then adds $VPN_NAMESERVER as dns server, this assumes you have the line in your resolv.conf
function vpn-on {
  cat ~/.vpn.routes | xargs -I {} sudo route add -net {} gw "$VPN_GATEWAY"
  sudo sed "s/# nameserver VPN_NAMESERVER/nameserver $VPN_NAMESERVER/g" -i /run/resolvconf/resolv.conf
}

# Deletes routes to gw for network addressed defined in ~/.vpn.routes
# Then comments out nameserver line in resolv.conf and reverts the variable
function vpn-off {
  cat ~/.vpn.routes | xargs -I {} sudo route del -net {} gw "$VPN_GATEWAY"
  sudo sed "s/nameserver $VPN_NAMESERVER/# nameserver VPN_NAMESERVER/g" -i /run/resolvconf/resolv.conf
}
