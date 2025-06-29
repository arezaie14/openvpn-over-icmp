#!/bin/sh

# Find the actual path of tinyproxy
TINYPROXY_BIN=$(which tinyproxy)

if [ ! -x "$TINYPROXY_BIN" ]; then
  echo "Error: tinyproxy binary not found!"
  exit 1
fi

# Generate config
envsubst < /etc/tinyproxy/tinyproxy.conf.template > /etc/tinyproxy/tinyproxy.conf

# Run tinyproxy
exec "$TINYPROXY_BIN" -d