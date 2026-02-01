#!/bin/bash

if [ -z "$@" ]; then
    echo "❌ Error: No command received! (CMD is empty)"
    exit 1
fi

INTERFACE_NAME=${INTERFACE_NAME:-"eth0"}

SN=$(cat /sys/class/dmi/id/product_serial)
MAC=$(cat /sys/class/net/"$INTERFACE_NAME"/address)
ID="agent-${ZONE_ID}/${BUILDING_ID}/${PROBE_ID}"

RESULT=$(ip -j addr show "$INTERFACE_NAME" | \
			 jq .[0] | \
			 jq -c '{interface: .ifname, mac_address: "'$MAC'", ip: .addr_info[0].local, serial_number: "'$SN'", id: "agent-'$ZONE_ID'/'$BUILDING_ID'/'$PROBE_ID'"}')

curl -X POST -H "Content-Type: application/json" -d "$RESULT" "$BACKEND_URL/agent/startup"

exec "$@"
