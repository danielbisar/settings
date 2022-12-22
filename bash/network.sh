#!/bin/bash

DEFAULT_GATEWAY="192.168.0.1"
DEFAULT_DEVICE="enp0s31f6"

# enable custom DNS for specified domains
echo "[Network]
DNS=1.1.1.1
DNS=1.0.0.1
Domains=copilot-proxy.githubusercontent.com gmail.com www.microsoft.com onedrive.live.com
" | sudo tee /usr/lib/systemd/network/99-bypass.network

# restart networking services
sudo systemctl stop systemd-resolved.service
sudo systemctl restart systemd-networkd.service
sudo systemctl start systemd-resolved.service
sudo resolvectl flush-caches

# update routing table to not use VPN for the specific ip ranges
mkdir -p /tmp/custom_network
cd /tmp/custom_network
rm goog.json
wget https://www.gstatic.com/ipranges/goog.json

echo "#!/bin/bash" > flush_routes.sh
chmod +x flush_routes.sh

for ip in $(jq .prefixes[].ipv4Prefix ./goog.json | grep -v null | tr -d '"'); do 
    echo Add route for "$ip" via "$DEFAULT_GATEWAY" dev "$DEFAULT_DEVICE"
    echo ip route add $ip via $DEFAULT_GATEWAY dev $DEFAULT_DEVICE
    sudo ip route add $ip via $DEFAULT_GATEWAY dev $DEFAULT_DEVICE

    echo "ip route flush $ip" >> flush_routes.sh
done








# other ip address ranges TODO
# for cloud services also use: https://www.gstatic.com/ipranges/cloud.json
# source: https://support.google.com/a/answer/10026322?hl=en

# github: 
# https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/about-githubs-ip-addresses
# https://api.github.com/meta

# microsoft:
# https://endpoints.office.com/endpoints/worldwide?clientrequestid=b10c5ed1-bad1-445f-b386-b919946339a7

