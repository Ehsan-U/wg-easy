#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

curl -sSL https://get.docker.com | sh
sudo usermod -aG docker $(whoami)

SERVER_IP=$(curl -s https://api.ipify.org)

docker run -d \
  --name=wg-easy \
  -e LANG=en \
  -e WG_HOST=$SERVER_IP \
  -e PASSWORD_HASH='$2a4NLLxuG' \
  -e PORT=51821 \
  -e WG_PORT=51820 \
  -v ~/.wg-easy:/etc/wireguard \
  -p 51820:51820/udp \
  -p 51821:51821/tcp \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_MODULE \
  --sysctl="net.ipv4.conf.all.src_valid_mark=1" \
  --sysctl="net.ipv4.ip_forward=1" \
  --restart unless-stopped \
  ghcr.io/wg-easy/wg-easy
