#!/bin/sh
# EpicMTD CM7 Download and Compile script
# VERSION 1.0

# Install packages for Ubuntu/Debian
sudo apt-get install git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.6-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev sun-java6-jdk pngcrush schedtool
# 64 bit OS only (comment the next line if you are on 32 bit)
sudo apt-get install g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline5-dev gcc-4.3-multilib g++-4.3-multilib 

# Create directories
mkdir ~/bin
mkdir ~/android
mkdir ~/android/system

# Download CyanogenMod Repo
cd ~/android/system/
repo init -u git://github.com/CyanogenMod/android.git -b gingerbread
repo sync -j6

# Create EpicMTD local manifest
echo '<?xml version="1.0" encoding="UTF-8"?>
  <manifest>
    <remote name="EpicCM" fetch="https://github.com" />

    <project
      path="device/samsung/epicmtd"
      name="EpicCM/android_device_samsung_epicmtd"
      remote="EpicCM" revision="blob-overlay"
     />
    <project
      path="vendor/cyanogen"
      name="EpicCM/android_vendor_cyanogen"
      remote="EpicCM"
      revision="epiccm-rebase"
    />
  </manifest>' > ~/android/system/.repo/local_manifest.xml

# Create local repo for EpicCM
repo start EpicCM --all
repo sync

# Get the RomManager
~/android/system/vendor/cyanogen/get-rommanager 

# Plug in your Epic running CM to get the proprietary files
cd ~/android/system/device/samsung/epicmtd
./extract-files.sh

# Fix to allow successful compile
cd ~/android/system/vendor/cyanogen
git cherry-pick a4a5133

cd ~/android/system

# Update repos
repo sync
make clobber

# Compile
. build/envsetup.sh
brunch epicmtd

