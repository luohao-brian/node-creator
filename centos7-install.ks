#services --enabled=auditd,ntpd,ntpdate,iptables,network,rsyslog,multipathd,snmpd,ovirt-early,ovirt-post,ovirt-kdump,ovirt-node-hooks,cgconfig,mcelog,tuned,libvirtd --disabled=netfs,ovirt-awake,libvirt-guests,kdump
services --enabled=iptables,network,rsyslog,libvirtd --disabled=netfs,kdump


