#!/bin/bash

#
# This script takes your locally built Kernel/arch/arm/boot/zImage and
# stuffs it into boot_zImage.zip, ready for kexec boot from CWM.
# This allows rapid testing of your local kernel builds.
#
# Copyright 2012 Warren Togami <wtogami@gmail.com>
# License: BSD

# Abort on error
set -e

if [ ! -f ./Kernel/arch/arm/boot/zImage ]; then
  echo "ERROR: File not found: ./Kernel/arch/arm/boot/zImage"
  echo 
  echo "       Run build_kernel.sh first?"
  echo
  exit 255
fi
echo cp ./Kernel/arch/arm/boot/zImage tools/kexec-cwm-test-zip/
cp ./Kernel/arch/arm/boot/zImage tools/kexec-cwm-test-zip/

if [ ! -f tools/kexec-cwm-test-zip/META-INF/com/google/android/update-binary ]; then
  if [ ! -f ../../../out/target/product/epicmtd/system/bin/updater ]; then
    echo "ERROR: File not found: ../../../out/target/product/epicmtd/system/bin/updater"
    echo 
    echo "       You probably need to 'make bacon' in order to build it, or manually put the binary at"
    echo "       tools/kexec-cwm-test-zip/META-INF/com/google/android/update-binary"
    echo
    exit 255
  fi
  echo cp ../../../out/target/product/epicmtd/system/bin/updater tools/kexec-cwm-test-zip/META-INF/com/google/android/update-binary
  cp ../../../out/target/product/epicmtd/system/bin/updater tools/kexec-cwm-test-zip/META-INF/com/google/android/update-binary
fi

rm -f boot_zImage.zip
cd tools/kexec-cwm-test-zip/
zip -r ../../boot_zImage.zip *
cd - > /dev/null

echo
echo "SUCCESS: Copy boot_zImage.zip to your /sdcard then CWM flash to safely test your local kernel build."
echo
