#
 # Copyright � 2016, Avinaba Dalal "corphish" <d97.avinaba@gmail.com>
 # Copyright � 2016, Zeeshan Hussain "zeeshanhussain" <zeeshanhussain12@gmail.com> 
 #
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

ZIP_DIR="/home/zeeshan/zip"
KERNEL="inazuma-mm"
RELEASE="R2"
REL_DIR="/home/zeeshan/Kernel-Release

cd $ZIP_DIR

zip -r $KERNEL-$RELEASE-$(date +"%Y%m%d").zip *

echo
if [ -f $ZIP_DIR/$KERNEL-$RELEASE-$(date +"%Y%m%d").zip ]
then
echo -e "Package Complete : $ZIP_DIR/raw/$KERNEL-$(date +"%Y%m%d")-$DEVICE.zip"
else
echo -e "Package Failed"
echo -e "Copying Generated zip to Release folder"
cp $KERNEL-$RELEASE-$(date +"%Y%m%d").zip $REL_DIR
echo -e "Build Done"
fi

