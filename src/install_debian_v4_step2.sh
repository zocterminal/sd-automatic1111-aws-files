#!/bin/bash
# vim: ff=unix 

#
# linux headers for nvidia building
#

echo 'Setting up NVIDIA-CUDA'

# source headers for debian kernel build (required for cuda build)
# (this will fail on some AWS specific debian images, make sure you
# run this on the Debian-11 AMI from Debian)
sudo apt -y install linux-headers-`uname -r` 

# get the cuda driver package
wget https://developer.download.nvidia.com/compute/cuda/12.0.0/local_installers/cuda_12.0.0_525.60.13_linux.run

# install the driver 
echo 'Building and installing driver ...'
echo 'Note: While cuda-install runs, you can continue with step 3 in another tab'
echo ''
sudo bash cuda_12.0.0_525.60.13_linux.run --driver --silent  # install drivers only

# check nvidia driver status
nvidia-smi

# done
echo 'If all is good, delete the driver package:'
echo '   rm cuda_12*'
echo ''

