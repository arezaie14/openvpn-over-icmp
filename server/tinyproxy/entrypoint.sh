#!/bin/sh

# Replace placeholders in the config template with env values
envsubst < /etc/tinyproxy/tinyproxy.conf.template > /etc/tinyproxy/tinyproxy.conf

# Start Tinyproxy in the foreground
/usr/sbin/tinyproxy -d