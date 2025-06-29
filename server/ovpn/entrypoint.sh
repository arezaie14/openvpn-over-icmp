#!/bin/sh
if [ ! -f /etc/openvpn/ovpn_env.sh ] && [ -d /etc/openvpn-back ]; then
    mv /etc/openvpn-back/* /etc/openvpn
fi
exec ovpn_run
