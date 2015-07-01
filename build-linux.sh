#!/bin/sh -eux

sudo apt-get -y install kmod

rm -rf linux-arm-modules
cd linux
KERNELVER=`make kernelversion`
make ARCH=arm zImage dtbs -j 4
make ARCH=arm modules -j 4
make ARCH=arm INSTALL_MOD_PATH="`pwd`/../linux-arm-modules" modules_install -j 4
cd ..
depmod -b "`pwd`/linux-arm-modules" -F linux/System.map ${KERNELVER}
