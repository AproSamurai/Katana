#!/bin/sh
#AproSamurai zImage to Boot.img creation for ICS
#Version 1.0

#Begin Process
cd ~/Android/Katana
git checkout ICS
./build_kernel.sh

#Create boot.img
cd ~/Android/create_boot.img
git checkout ICS
./create_boot.img.sh cm

#Create boot.img Directory
cd ~/Android/KatanaKernel
cp ~/Android/create_boot.img/boot.img ~/Android/KatanaKernel/boot.img

#Create update.zip
mkdir ~/Android/KernelOutput
rm -f ~/Android/KernelOutput/KatanaAOSP.zip
tar -cvzf ~/Android/KernelOutput/KatanaAOSP.zip ~/Android/KatanaKernel*
