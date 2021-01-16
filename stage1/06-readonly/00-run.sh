#!/bin/bash -e
# https://github.com/cashpipeplusplus
# https://raw.githubusercontent.com/cashpipeplusplus/pi-gen/fcb5dcc1f992eba2d42fe29d009364e51b2a49b7/stage3/03-readonly/00-run.sh

on_chroot sh -e - <<EOF
# Do not resize the filesystem on first boot.
update-rc.d resize2fs_once remove
rm /etc/init.d/resize2fs_once

# Set up SSH keys now since we can't in read-only mode.
#yes | ssh-keygen -q -N '' -t dsa -f /etc/ssh/ssh_host_dsa_key
#yes | ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key
#yes | ssh-keygen -q -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
#yes | ssh-keygen -q -N '' -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
#rm /etc/init.d/regenerate_ssh_host_keys
#update-rc.d regenerate_ssh_host_keys remove

# Don't try to apply noobs config after boot, either.
update-rc.d apply_noobs_os_config remove
rm /etc/init.d/apply_noobs_os_config

# Replace rsyslog with a busybox version that works purely in memory.
apt-get remove -y --purge rsyslog
apt-get install -y busybox-syslogd

# Clean up.
apt-get clean

# Make some tmpfs mounts.
echo "tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0" >> /etc/fstab
echo "tmpfs /run tmpfs defaults,nosuid,nodev 0 0" >> /etc/fstab

# Move some system files to /tmp.
rm -rf /var/tmp
ln -s /tmp /var/tmp

rm -rf /var/lib/dhcp
ln -s /tmp /var/lib/dhcp

rm -rf /var/lib/systemd/random-seed
ln -s /tmp/random-seed /var/lib/systemd/random-seed
echo 'ExecStartPre=/bin/echo > /tmp/random-seed' >> /lib/systemd/system/systemd-random-seed.service

# Bluez needs writable space at boot or it will not work.
ln -s /tmp /var/lib/bluetooth

# Trash these.
rm -rf /var/log
rm -rf /var/mail

# Put this one back or apt freaks out during export.
mkdir -p /var/log/apt

# Make the system boot in read-only mode.
sed -e 's/$/ fastboot noswap ro/' -i /boot/cmdline.txt
sed -e 's@ /boot .*defaults@&,ro@' -e 's@ / .*defaults,noatime@&,ro@' -i /etc/fstab
EOF
