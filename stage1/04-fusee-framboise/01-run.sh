#!/bin/bash -e

on_chroot << EOF
pip3 install pyusb
EOF

rm -rf ${ROOTFS_DIR}/etc/fusee-launcher

mkdir -p ${ROOTFS_DIR}/etc/fusee-launcher

git clone "https://github.com/Qyriad/fusee-launcher" ${ROOTFS_DIR}/etc/fusee-launcher

curl -L -o ${ROOTFS_DIR}/etc/fusee-launcher/hekate.zip "https://github.com/CTCaer/hekate/releases/download/v5.5.4-v2/hekate_ctcaer_5.5.4_Nyx_1.0.1.zip"

unzip ${ROOTFS_DIR}/etc/fusee-launcher/hekate.zip -d ${ROOTFS_DIR}/etc/fusee-launcher

mv -v ${ROOTFS_DIR}/etc/fusee-launcher/hekate_ctcaer_5.5.4.bin ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin

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
