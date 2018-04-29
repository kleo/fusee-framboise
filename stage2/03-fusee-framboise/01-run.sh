#!/bin/bash -e

on_chroot << EOF
pip3 install pyusb
EOF

mkdir -p ${ROOTFS_DIR}/etc/fusee-launcher

git clone "https://github.com/reswitched/fusee-launcher" ${ROOTFS_DIR}/etc/fusee-launcher/

curl -o ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin "https://misc.ktemkin.com/fusee.bin"

touch $ROOTFS_DIR/etc/systemd/system/fusee-launcher.service

chmod 770 $ROOTFS_DIR/etc/systemd/system/fusee-launcher.service

cat << EOF > $ROOTFS_DIR/etc/systemd/system/fusee-launcher.service
[Unit]
Description = Fusee Launcher service of Fusée Framboise
After = network.target

[Service]
ExecStart = /etc/fusee-launcher/modchipd.sh

[Install]
WantedBy = multi-user.target
EOF

on_chroot << EOF
systemctl enable fusee-launcher.service
EOF
