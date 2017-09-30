#!/bin/bash

make_python_venv () {
    python3.6 -m venv $1

}

alias venv_cv2='source /srv/cv2/venv_cv2/bin/activate'

centroid_dir='/srv/centroid/'
alias cd_centroid='cd '$centroid_dir


# why is import cv2 functional only when venv_cv2 runned from /srv/

