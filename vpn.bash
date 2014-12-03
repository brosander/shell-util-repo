function vpn-on {
  cat ~/.vpn.routes | xargs -I {} sudo route add -net {} gw "$VPN_GATEWAY"
  sudo sed "s/# nameserver VPN_NAMESERVER/nameserver $VPN_NAMESERVER/g" -i /etc/resolv.conf
}

function vpn-off {
  cat ~/.vpn.routes | xargs -I {} sudo route del -net {} gw "$VPN_GATEWAY"
  sudo sed "s/nameserver $VPN_NAMESERVER/# nameserver VPN_NAMESERVER/g" -i /etc/resolv.conf
}
