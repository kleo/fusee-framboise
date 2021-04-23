#!/bin/bash -e

on_chroot << EOF
pip3 install pyusb
EOF

rm -rf ${ROOTFS_DIR}/etc/fusee-launcher

mkdir -p ${ROOTFS_DIR}/etc/fusee-launcher

curl -L -o ${ROOTFS_DIR}/etc/fusee-launcher/1.0.zip https://github.com/Qyriad/fusee-launcher/archive/refs/tags/1.0.zip

unzip -j ${ROOTFS_DIR}/etc/fusee-launcher/1.0.zip -d ${ROOTFS_DIR}/etc/fusee-launcher

wget -P ${ROOTFS_DIR}/etc/fusee-launcher ${PAYLOAD_LATEST_URL}

if compgen -G "${ROOTFS_DIR}/etc/fusee-launcher/hekate*.zip" > /dev/null; then
    unzip ${ROOTFS_DIR}/etc/fusee-launcher/hekate*.zip -d ${ROOTFS_DIR}/etc/fusee-launcher \
    && find ${ROOTFS_DIR}/etc/fusee-launcher -name "hekate*.bin" -exec mv '{}' ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin \;
elif compgen -G "${ROOTFS_DIR}/etc/fusee-launcher/fusee-primary.bin" > /dev/null; then
    find ${ROOTFS_DIR}/etc/fusee-launcher -name "fusee-primary.bin" -exec mv '{}' ${ROOTFS_DIR}/etc/fusee-launcher/fusee.bin \;
fi

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
