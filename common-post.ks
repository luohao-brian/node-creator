# -*-Shell-script-*-
echo "Starting Kickstart Post"
PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

# cleanup rpmdb to allow non-matching host and chroot RPM versions
echo "Removing yumdb data"
rm -f /var/lib/rpm/__db*

echo "Creating shadow files"
# because we aren't installing authconfig, we aren't setting up shadow
# and gshadow properly.  Do it by hand here
pwconv
grpconv

# root's bash profile
cat >> /root/.bashrc << \EOF_bashrc
alias ping='ping -c 3'
EOF_bashrc

#strip out all unncesssary locales
localedef --list-archive | grep -v -i -E 'en_US.utf8' |xargs localedef --delete-from-archive
mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl
/usr/sbin/build-locale-archive

echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# disable SSH password auth by default
# set ssh timeouts for increased security
augtool << \EOF_sshd_config
set /files/etc/ssh/sshd_config/PasswordAuthentication no
set /files/etc/ssh/sshd_config/ClientAliveInterval 900
set /files/etc/ssh/sshd_config/ClientAliveCountMax 0
save
EOF_sshd_config

echo "disable yum repos by default"
rm -f /tmp/yum.aug
for i in $(augtool match /files/etc/yum.repos.d/*/*/enabled 1); do
    echo "set $i 0" >> /tmp/yum.aug
done
if [ -f /tmp/yum.aug ]; then
    echo "save" >> /tmp/yum.aug
    augtool < /tmp/yum.aug
    rm -f /tmp/yum.aug
fi

echo "cleanup yum directories"
rm -rf "/var/lib/yum/*"

