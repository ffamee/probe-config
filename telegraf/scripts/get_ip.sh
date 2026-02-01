#!/bin/bash

INTERFACE_NAME=${INTERFACE_NAME:-"eth0"}

RESULT=$(ip -j addr show "$INTERFACE_NAME" | jq .[0] | jq -c '{ip: .addr_info[0].local, status: (if .addr_info[0].local == null then 1 else 0 end)}')

echo "$RESULT"
