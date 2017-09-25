#!/bin/bash

speak_install()
{
    echo "do not know how"
    # ansible-playbook
}

say() {
(pico2wave -w lookdave.wav "I say:" > /dev/null && aplay lookdave.wav > /dev/null 2>&1 )
(pico2wave -w lookdave.wav "'$*'" && aplay lookdave.wav > /dev/null 2>&1 &)
}

