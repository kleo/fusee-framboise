#!/bin/bash -e

on_chroot << EOF
pip3 install pyusb
EOF

mkdir -p ${ROOTFS_DIR}/etc/fusee-launcher

git clone "https://github.com/Cease-and-DeSwitch/fusee-launcher" ${ROOTFS_DIR}/etc/fusee-launcher/

curl -o ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin "https://github.com/CTCaer/hekate/releases/download/v3.2/hekate_ctcaer_3.2.bin"

touch $ROOTFS_DIR/etc/systemd/system/fusee-launcher.service

chmod 770 $ROOTFS_DIR/etc/systemd/system/fusee-launcher.service

cat << EOF > $ROOTFS_DIR/etc/systemd/system/fusee-launcher.service
[Unit]
Description = Fusee Launcher service of Fusée Framboise
After = network.target

[Service]
WorkingDirectory=/etc/fusee-launcher/
ExecStart = /etc/fusee-launcher/modchipd.sh

[Install]
WantedBy = multi-user.target
EOF

on_chroot << EOF
systemctl enable fusee-launcher.service
EOF
