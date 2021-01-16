#!/bin/bash -e
# https://github.com/cashpipeplusplus
# https://raw.githubusercontent.com/cashpipeplusplus/pi-gen/fcb5dcc1f992eba2d42fe29d009364e51b2a49b7/stage3/04-trim-fat/00-run.sh

# NOTE: must be bash, since I'm using fancy expansions below.
on_chroot bash -e - <<EOF

# Remove some packages we don't need.
apt-get remove -y --purge \
  avahi-daemon logrotate triggerhappy dphys-swapfile \
  libraspberrypi-dev libraspberrypi-doc libfreetype6-dev \
  xauth xdg-user-dirs xkb-data \
  wpasupplicant wireless-regdb wireless-tools iw \
  samba-common cifs-utils sgml-base xml-core \
  v4l-utils traceroute tcpd rsync netcat-openbsd netcat-traditional \
  ncdu manpages manpages-dev locales \
  libxapian22 aptitude iptables
  
# Remove any packages which are no longer depended on.
apt-get autoremove -y --purge

# Remove boot services we do not need.
for i in bootlogs motd rmnologin; do
  update-rc.d \$i remove
done

# Trash kernel for old Pi 2 models (we use Pi zero only).
# rm -rf /lib/modules/4.4.26-v7+ /boot/kernel7.img

# Trash docs.
rm -rf /usr/share/doc /usr/share/man

# Trash non-English locales.
mkdir /usr/share/locale.bk
mv /usr/share/locale/en* /usr/share/locale.bk/
rm -rf /usr/share/locale
mv /usr/share/locale{.bk,}

# Clean up.
apt-get clean
rm -rf /var/lib/apt/lists
EOF
