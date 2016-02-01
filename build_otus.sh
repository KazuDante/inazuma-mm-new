
#
 # Copyright � 2016, Zeeshan Hussain "zeeshanhussain" <zeeshanhussain12@gmail.com>
 # Custom build script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 #

#!/bin/bash
#Define Variables
ZIMAGE="/home/zeeshan/condor-trees/inazuma-mm-new/arch/arm/boot/zImage-dtb"
KERNEL_DIR="/home/zeeshan/condor-trees/inazuma-mm-new"
ZIP_DIR="/home/zeeshan/zip"
KERNEL="zImage-dtb"

#Main Process starts from here
BUILD_START=$(date +"%s")
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=/home/zeeshan/uber-5.2/bin/arm-eabi-
export KBUILD_BUILD_USER="zeeshan"
export KBUILD_BUILD_HOST="thunder-prince"
if [ -a $KERNEL_DIR/arch/arm/boot/$KERNEL ];
then
rm $ZIMAGE
rm $ZIP_DIR/system/lib/modules/*
fi
echo "Initialize Defconfig" 
make cm_otus_defconfig
echo "Building Kernel"

make -j4 zImage-dtb
echo "Building Modules"
make -j4 modules
echo "Copying kernel"
cp $KERNEL_DIR/arch/arm/boot/$KERNEL $ZIP_DIR/kernel/$KERNEL
if [ -a $ZIMAGE ];
then
echo "Copying modules"
find . -name '*.ko' -exec cp {} $ZIP_DIR/system/lib/modules \;
sleep 2
#Move Wlan driver to proper place
mv /home/zeeshan/zip/system/lib/modules/wlan.ko /home/zeeshan/zip/system/lib/modules/pronto/pronto_wlan.ko
echo "Compressing Kernel zip"
cd $KERNEL_DIR
. zip.sh $1
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
else
echo "Compilation failed! Fix the errors!"
fi



