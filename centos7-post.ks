# According with man systemd-journald.service:
# By default, the journal stores log data in /run/log/journal/.
# Since /run/ is volatile, log data is lost at reboot. To make the data
# persistent, it is sufficient to create /var/log/journal/ where
# systemd-journald will then store the data
install -dm 0755 /var/log/journal

echo "Configuring eth0 networking"
cat <<EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
BOOTPROTO=dhcp
DEVICE=eth0
ONBOOT=yes
TYPE=Ethernet
EOF

echo "Configuring IPTables"
# here, we need to punch the appropriate holes in the firewall
cat > /etc/sysconfig/iptables << \EOF
# Automatically generated firewall configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
# SSH
-A INPUT -p tcp --dport 22 -j ACCEPT
# guest consoles
-A INPUT -p tcp -m multiport --dports 5900:6923 -j ACCEPT
# migration
-A INPUT -p tcp -m multiport --dports 49152:49216 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -m physdev ! --physdev-is-bridged -j REJECT --reject-with icmp-host-prohibited
COMMIT
EOF

# configure IPv6 firewall, default is all ACCEPT
cat > /etc/sysconfig/ip6tables << \EOF
# Automatically generated firewall configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p ipv6-icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
# SSH
-A INPUT -p tcp --dport 22 -j ACCEPT
# guest consoles
-A INPUT -p tcp -m multiport --dports 5900:6923 -j ACCEPT
# migration
-A INPUT -p tcp -m multiport --dports 49152:49216 -j ACCEPT
# unblock ipv6 dhcp response
-A INPUT -p udp --dport 546 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp6-adm-prohibited
-A FORWARD -m physdev ! --physdev-is-bridged -j REJECT --reject-with icmp6-adm-prohibited
COMMIT
EOF

# set maxlogins to 3
echo "*        -       maxlogins      3" >> /etc/security/limits.conf
