#!/bin/bash

cd /home/deploy/qt5
VERSION=$(git rev-parse --abbrev-ref HEAD) 
ROOTFS=$1
mkdir  /home/deploy/$ROOTFS
mkdir /home/deploy/$ROOTFS/$VERSION
mkdir /home/deploy/$ROOTFS/sdk
mkdir /home/deploy/$ROOTFS/sdk/$VERSION
echo "CONFIGURING BUILD"
./configure -release -opengl es2 -device linux-arm-generic-g++  \
	-device-option CROSS_COMPILE=/usr/bin/arm-linux-gnueabihf- -sysroot /home/deploy/rootfs/$ROOTFS  \
	 -opensource -confirm-license -skip qtwayland -skip qtlocation -skip qtwebengine -skip qtscript  \
	-no-feature-accessibility -make libs -prefix /usr/local/$VERSION  -extprefix /home/deploy/$ROOTFS/$VERSION  \
	-hostprefix /home/deploy/$ROOTFS/sdk/$VERSION -no-use-gold-linker -v -no-gbm
echo "BUILD STARTED"
make -j $(nproc --all)

