#!/bin/bash

# cz 
# https://sites.google.com/a/vutbr.cz/bprp/cviceni/2016/8
# en
## with virtualenv and virtualenvwrapper - good 
# https://www.pyimagesearch.com/2016/04/18/install-guide-raspberry-pi-3-raspbian-jessie-opencv-3/

echo "### Going to install OpenCV 3.3 into python3.6"
base_dir='/srv/cv2'
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential cmake pkg-config


sudo apt-get install git

echo ">>> Installing python 3.6"
# install python 3.6
~/gr4log/scripts/installit/rpi/py3.6.sh

# create virtualenv
cd $base_dir
venv_str="venv_cv2"
venv_dir="$base_dir/$venv_str"
venv_file=$venv_dir/bin/activate
echo ">>> Installing virtual env in "$venv_dir

if [ -f $venv_file ]; then
    echo "Virtual env already exists in "$venv_dir
else
    python 3.6 -m venv $venv_str
fi

source venv_cv2/bin/activate
echo $PS1

echo ">>> Installing numpy"
pip install numpy -vv


echo ">>> Installing latest OpenCV from source - with contrib"
cd $base_dir
opencv_dir=$base_dir'/opencv'
contrib_dir=$base_dir'/opencv_contrib'
git clone https://github.com/Itseez/opencv.git $opencv_dir
git clone https://github.com/Itseez/opencv_contrib.git $contrib_dir

# sudo apt-get -y install libjpeg-dev 
sudo apt-get -y install libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install libatlas-base-dev gfortran

# for video streaming
sudo apt-get -y install libav-tools
sudo apt-get -y install libjpeg8-dev imagemagick libv4l-dev


# another from
# http://dev.t7.ai/jetson/opencv/

# basic
sudo apt-get -y install build-essential
sudo apt-get -y install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev

# GStreamer support (recommended)
sudo apt-get -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

# OpenGL support
sudo apt-get -y install libgtkglext1 libgtkglext1-dev
sudo apt-get -y install qtbase5-dev

# video4linux2 support (better handling of usb cameras modes)
sudo apt-get -y install libv4l-dev v4l-utils qv4l2 v4l2ucp


build_dir=$opencv_dir'/build'
mkdir $build_dir
cd $build_dir

contrib_modules=$contrib_dir'/modules'
c_examples_dir=$opencv_dir

py3_include_dir=$(python -c "from sysconfig import get_paths; print(get_paths()['include'])")
numpy_dir=$(python -c "import numpy; print(numpy.__path__[0])")
numpy_include_dir=$numpy_dir'/core/include/'

cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D WITH_OPENGL=ON \
    -D WITH_LIBV4L=ON \
    -D OPENCV_EXTRA_MODULES_PATH=$contrib_modules \
    -D PYTHON_INCLUDE_DIR=$py3_include_dir \
    -D PYTHON3_NUMPY_INCLUDE_DIRS=$numpy_include_dir \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_EXAMPLES=ON $c_examples_dir 

cd $build_dir
make -j 4
sudo make install
