#!bin/bash

/sbin/ifconfig eth0:12 192.168.11.1 up
/sbin/route add -net 192.168.11.0 netmask 255.255.255.0 gw 192.168.11.2
/sbin/ifconfig eth0:45 192.168.21.1 up
/sbin/route add -net 192.168.21.0 netmask 255.255.255.0 gw 192.168.21.2


#At Web Server 1

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@192.168.19.137 << EOT

/sbin/ifconfig eth0:12 192.168.11.2 up
/sbin/route add -net 192.168.11.0 netmask 255.255.255.0 gw 192.168.11.1
/sbin/ifconfig eth0:23 192.168.12.1 up
/sbin/route add -net 192.168.12.0 netmask 255.255.255.0 gw 192.168.12.2
/sbin/sysctl -w net.ipv4.ip_forward=1
/sbin/iptables -A INPUT -p all -d 192.168.11.2 -j ACCEPT
/sbin/iptables -A INPUT -p all -d 192.168.21.2 -j DROP


#Go to database server and setup interfaces

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@192.168.19.135 << foo

/sbin/sysctl -w net.ipv4.ip_forward=1
/sbin/ifconfig eth0:23 192.168.12.2 up
/sbin/route add -net 192.168.11.0 netmask 255.255.255.0 gw 192.168.12.1
/sbin/ifconfig eth0:56 192.168.22.2 up
/sbin/route add -net 192.168.21.0 netmask 255.255.255.0 gw 192.168.22.1
/sbin/iptables -A -p all INPUT -s 192.168.19.137 -j ACCEPT
/sbin/iptables -A -p all INPUT -s 192.168.19.140 -j ACCEPT
foo

EOT

#At Web Server 2

ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no root@192.168.19.140 << foo1

/sbin/ifconfig eth0:45 192.168.21.2 up
/sbin/route add -net 192.168.21.0 netmask 255.255.255.0 gw 192.168.21.1
/sbin/ifconfig eth0:56 192.168.22.1 up
/sbin/route add -net 192.168.22.0 netmask 255.255.255.0 gw 192.168.22.2
/sbin/sysctl -w net.ipv4.ip_forward=1
/sbin/iptables -A INPUT -p all -d 192.168.21.2 -j ACCEPT
/sbin/iptables -A INPUT -p all -d 192.168.11.2 -j DROP

foo1
                                        
