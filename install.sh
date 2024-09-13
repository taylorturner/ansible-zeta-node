#!/bin/bash
# Wrapper script to simplify handling the inventory file

if [ -z "$1" ]; then
  echo "Usage: $0 <IP_ADDRESS>"
  exit 1
fi

IP_ADDRESS=$1

cat <<EOF > inventory
[target]
$IP_ADDRESS
EOF

echo "Inventory file created with target IP: $IP_ADDRESS"
