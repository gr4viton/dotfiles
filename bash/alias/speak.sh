#!/bin/bash

inst_speak () {
    inst libttspico-utils
}

say_noise () {
    # from https://www.commandlinefu.com/commands/view/14278/aplay-some-whitenoise
    # plays white noise generated by urandom
    aplay -c 2 "$@" -f S16_LE -r 44100 /dev/urandom > /dev/null 2>&1
}

say_noise_sec () {
    echo "> playing white noise - $sec seconds"
    sec="${1:-0}"
    say_noise -d $sec
}
say_noise_roger () {
    samples="${1:-20000}"
    say_noise -s $samples
}

say () {
    file="/tmp/lookdave.wav"
    echo "$file"
    (pico2wave -w $file "'$*'" && aplay $file > /dev/null 2>&1 &)
}

say2 () {
    say_noise_roger

    # echo "$@"
    # file="/tmp/lookdave.wav"
    # pico2wave -w $file "$@"
    # aplay $file > /dev/null 2>&1
    say "$@"
}

isay() {
    say I say
    say $*
}
