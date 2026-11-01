#!/bin/bash

set -xe

#make mrproper
make CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 LLVM_IAS=1 ARCH=arm64 kedge2_defconfig android-14.config kedge2_defconfig pcie_wifi.config
make CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 LLVM_IAS=1 ARCH=arm64 dtbs
#make CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 LLVM_IAS=1 ARCH=arm64 rk3588s-khadas-edge2.img -j`nproc`
make CROSS_COMPILE=aarch64-linux-gnu- LLVM=1 LLVM_IAS=1 ARCH=arm64 rk3588-aiot-3588ied.img -j`nproc`

rm -f boot.img

PRODUCT_OUT=`pwd`
OUTPUT_IMG="${PRODUCT_OUT}/boot.img"

KERNEL="${PRODUCT_OUT}/arch/arm64/boot/Image"
RAMDISK="${PRODUCT_OUT}/ramdisk.img"
DTB="${PRODUCT_OUT}/arch/arm64/boot/dts/rockchip/rk3588-aiot-3588ied.dtb"
SECOND_STAGE="resource.img"
CMDLINE="console=ttyFIQ0 firmware_class.path=/vendor/etc/firmware init=/init rootwait ro loop.max_part=7 printk.devkmsg=on kvm-arm.mode=none androidboot.console=ttyFIQ0 androidboot.wificountrycode=CN androidboot.hardware=rk30board androidboot.boot_devices=fe2e0000.mmc androidboot.selinux=permissive"

MAX_SIZE=67108864
mkbootimg \
    --kernel "${KERNEL}" \
    --ramdisk "${RAMDISK}" \
    --dtb "${DTB}" \
    --cmdline "${CMDLINE}" \
    --os_version 14 \
    --os_patch_level 2024-02-05 \
    --second "${SECOND_STAGE}" \
    --header_version 2 \
    --output "${OUTPUT_IMG}"
ls -lha boot.img


