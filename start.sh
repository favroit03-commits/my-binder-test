#!/bin/bash

# Force Tailscale to stay in userspace
export TS_USERSPACE=true
export TS_NO_DIRECT_HW_CONFIG=true

# Start the daemon with explicit flags
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &

# Wait for it to initialize
sleep 5

# Auth check
if [ -z "$TAILSCALE_AUTHKEY" ]; then
    echo "ERROR: TAILSCALE_AUTHKEY is not set in Railway variables!"
else
    tailscale up --authkey=$TAILSCALE_AUTHKEY --hostname=railway-vps --accept-routes
fi

# Keep SSH alive
/usr/sbin/sshd -D
