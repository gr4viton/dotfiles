#!/bin/bash

base_dir='/srv/cv2'
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential cmake pkg-config


sudo apt-get install git
sudo apt-get install python3-dev
sudo apt-get install python3-pip
sudo pip3 install numpy

cd $base_dir
opencv_dir=$base_dir'/opencv'
contrib_dir=$base_dir'/opencv_contrib'
git clone https://github.com/Itseez/opencv.git $opencv_dir
git clone https://github.com/Itseez/opencv_contrib.git $contrib_dir

sudo apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install libatlas-base-dev gfortran

# for video streaming
sudo apt-get -y install libav-tools
sudo apt-get -y install libjpeg8-dev imagemagick libv4l-dev

build_dir=$opencv_dir'/build'
mkdir $build_dir
cd $build_dir

contrib_modules=$contrib_dir'/modules'
c_examples_dir=$opencv_dir

py3_dir='/usr/include/python3.4'

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D OPENCV_EXTRA_MODULES_PATH=$contrib_modules \
    -D PYTHON_INCLUDE_DIR=/usr/include/python3.4/ \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/lib/python3.4/dist-packages/numpy/core/include/ \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_EXAMPLES=ON $c_examples_dir 

cd $build_dir
make -j 4
sudo make install
