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
    # Create veth interfaces
    ip link add name veth01-host type veth peer name veth01-guest
    ip link add name veth02-host type veth peer name veth02-guest
    ip link set veth01-host up
    ip link set veth02-host up
    # Add veth interface to the bridge we created
    ip link set veth01-host master byop0
    ip link set veth02-host master byop0
    # Assign address to host veth interface
    ip addr add 192.168.10.110/24 dev veth01-host
    ip addr add 192.168.10.120/24 dev veth02-host
    # Create network namespace
    ip netns add runc
    # Put veth interface for guest in created network namespace
    ip link set veth01-guest netns runc
    ip link set veth02-guest netns runc
    # Configure container veth interface
    ip netns exec runc ip link set veth01-guest name eth01
    ip netns exec runc ip link set veth02-guest name eth02
    ip netns exec runc ip addr add 192.168.10.111/24 dev eth01
    ip netns exec runc ip addr add 192.168.10.121/24 dev eth02
    ip netns exec runc ip link set eth01 up
    ip netns exec runc ip link set eth02 up
    ip netns exec runc ip route add default via 192.168.10.1
}

function delete {
    ip link delete veth01-host
    ip link delete veth02-host
    ip netns delete runc
    ip link delete byop0
}

$do_what
