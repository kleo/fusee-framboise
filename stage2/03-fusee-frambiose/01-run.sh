#!/bin/bash -e

on_chroot << EOF
pip3 install pyusb
EOF

mkdir -p ${ROOTFS_DIR}/etc/fusee-launcher

git clone "https://github.com/reswitched/fusee-launcher" ${ROOTFS_DIR}/etc/fusee-launcher/

curl -o ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin "https://misc.ktemkin.com/fusee.bin"
