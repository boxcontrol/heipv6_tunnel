#!/bin/bash
echo "Create Tunnel at http://www.tunnelbroker.net/"
echo 'NETWORKING_IPV6=yes' >>  /etc/sysconfig/network
echo "Enter name for new device (For example HETunnel)"
read dev_name
echo "Enter HE Server IPv4 address"
read he_ipv4
echo "Enter Server IPv6 address, without /64"
read server_ipv6
echo "IPV6_DEFAULTGW=${server_ipv6}" >> /etc/sysconfig/network
echo "Enter Client IPv4 address"
read client_ipv4
echo "Enter Client IPv6 address (keep /64)"
read client_ipv6
touch /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "DEVICE=${dev_name}" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "BOOTPROTO=none" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "ONBOOT=yes" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "IPV6INIT=yes" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "IPV6TUNNELIPV4=${he_ipv4}" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "IPV6TUNNELIPV4LOCAL=${client_ipv4}" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "IPV6ADDR=${client_ipv6}" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "IPV6_DEFAULTGW=${server_ipv6}" >> /etc/sysconfig/network-scripts/ifcfg-$dev_name
echo "Setting up sysctl"
sysctl net.ipv6.conf.all.forwarding=1
echo 'net.ipv6.conf.all.forwarding=1' >> /etc/sysctl.conf
echo 'net.ipv6.conf.all.proxy_ndp = 1' >> /etc/sysctl.conf
ifup $dev_name
