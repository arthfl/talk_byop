#!/usr/bin/env bash

if [[ $(id -u) -ne 0 ]]; then
    echo "Run me with sudo, you fool!"
    exit 1
fi

do_what="$1"

# Show me what you do
set -x

function create {
    # Create bridge
    ip link add name byop0 type bridge
    ip link set byop0 up
    # Give bridge an IP address
    ip addr add 192.168.10.1/24 dev byop0
    # Create veth interface
    ip link add name veth-host type veth peer name veth-guest
    ip link set veth-host up
    # Add veth interface to the bridge we created
    ip link set veth-host master byop0
    # Assign address to host veth interface
    ip addr add 192.168.10.102/24 dev veth-host
    # Create network namespace
    ip netns add runc
    # Put veth interface for guest in created network namespace
    ip link set veth-guest netns runc
    # Configure container veth interface
    ip netns exec runc ip link set veth-guest name eth1
    ip netns exec runc ip addr add 192.168.10.101/24 dev eth1
    ip netns exec runc ip link set eth1 up
    ip netns exec runc ip route add default via 192.168.10.1
}

function delete {
    ip link delete veth-host
    ip netns delete runc
    ip link delete byop0
}

$do_what
