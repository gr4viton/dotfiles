#!/bin/bash

speak_install()
{
    echo "do not know how"
    # ansible-playbook
}

say() {
(pico2wave -w lookdave.wav "'$*'" && aplay lookdave.wav > /dev/null 2>&1 &)
}

isay() {
say I say
say $*
}
