#!/bin/bash -e

on_chroot << EOF
pip3 install pyusb
EOF

mkdir -p ${ROOTFS_DIR}/etc/fusee-launcher

git clone "https://github.com/reswitched/fusee-launcher" ${ROOTFS_DIR}/etc/fusee-launcher/

curl -o ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin "https://misc.ktemkin.com/fusee.bin"

touch /etc/systemd/system/fusee-launcher.service

/etc/systemd/system/fusee-launcher.service << EOF
[Unit]
Description=Fusée Launcher service of Fusée Framboise
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/etc/fusee-launcher/
ExecStart=/etc/fusee-launcher/modchipd.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

on_chroot << EOF
systemctl enable fusee-launcher
EOF
