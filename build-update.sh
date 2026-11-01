#!/bin/bash

set -x
WORKDIR=`pwd`
PACK_TOOL_DIR="${WORKDIR}/RKTools/linux/Linux_Pack_Firmware/"
OUTPUT_DIR="${WORKDIR}/rockdev/"

# env prep
mkdir -p ${OUTPUT_DIR}
chmod +x ${WORKDIR}/RKTools/linux/Linux_Pack_Firmware/rockdev/afptool
chmod +x ${WORKDIR}/RKTools/linux/Linux_Pack_Firmware/rockdev/rkImageMaker

# gen image
mkdir -p ${PACK_TOOL_DIR}/rockdev/Image/
cd ${PACK_TOOL_DIR}/rockdev/Image/

if [ ! -f MiniLoaderAll.bin ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/MiniLoaderAll.bin
fi
#if [ ! -f MiniLoaderAll.bin ] ; then
#  wget -q -c -O MiniLoaderAll.bin https://github.com/yifengyou/rockchip-uboot-mainline/releases/download/aiot-3588a-uboot/rk3588_spl_loader_v1.21.114.bin
#fi

#if [ ! -f parameter.txt ] ; then
#  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/parameter.txt
#fi
cp -a ${WORKDIR}/update-template/parameter.txt .

if [ ! -f uboot.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/aiot_3588ied_uboot/uboot.img
fi
#if [ ! -f uboot.img ] ; then
#  wget -q -c https://github.com/yifengyou/rockchip-uboot-mainline/releases/download/aiot-3588a-uboot/uboot.img
#fi

if [ ! -f boot.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/aiot_3588ied_kernel/boot.img
fi

# 手机助手
if [ ! -f rkdev.img ] ; then
  wget -q -c -O rkdev.img https://github.com/yifengyou/rockchip-ophub-linux-6.18.y/releases/download/aiot-3588ied-recovery/recovery.img
fi

if [ ! -f misc.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/misc.img
fi
if [ ! -f dtbo.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/dtbo.img
fi
if [ ! -f vbmeta.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/vbmeta.img
fi
if [ ! -f recovery.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/recovery.img
fi
if [ ! -f baseparameter.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/baseparameter.img
fi
if [ ! -f super.img ] ; then
  wget -q -c https://github.com/yifengyou/rockchip-khadas-android14/releases/download/android14_base_image/super.img
fi

ls -alh

# pack image
echo "-----------------------------------------------------------------------"
echo "Make update.img"
cd ${PACK_TOOL_DIR}/rockdev && ./mkupdate.sh rk3588 Image

if [ $? -eq 0 ]; then
    echo "Make update image ok!"
else
    echo "Make update image failed!"
    exit 1
fi

echo "-----------------------------------------------------------------------"
mv ${PACK_TOOL_DIR}/rockdev/update.img ${OUTPUT_DIR}
ls -alh ${OUTPUT_DIR}
