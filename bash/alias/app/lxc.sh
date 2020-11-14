# LXC
## original reason for trying LXC + LXD
## the ros2 foxy needs ubuntu 20.04 - i have ubuntu 19.10
## though i can run the ubuntu 20.04 via LXC (even with gui apps)

LXC_CONT="bestest"

# plain LXC
_lxc_create () {
    echo "from https://linuxcontainers.org/lxc/getting-started/"
    sudo lxc-create -t download -n $LXC_CONT
}
_lxc_start () {
    sudo lxc-start -n $LXC_CONT -d
    sudo lxc-info -n $LXC_CONT
}
_lxc_attach () { sudo lxc-attach -n $LXC_CONT ; }
_lxc_stop () { sudo lxc-stop -n $LXC_CONT ; }
_lxc_delete () { sudo lxc-destroy -n $LXC_CONT ; }
_lxc_restart () { lxc_stop; lxc_start; }
_lxc_restart_attach () { lxc_stop; lxc_start; lxc_attach; }
_lxc_config () {
    vim $HOME/.config/lxc/default.conf
    # $HOME/.local/share/lxc
}

# when using LXC installed via LXD

lxc_launch () { lxc launch ubuntu:20.04 $LXC_CONT ; }
lxc_delete () { lxc delete $LXC_CONT ; }
lxc_list () { lxc list ; }
lxc_start () { lxc start $LXC_CONT ; }
lxc_stop () { lxc stop $LXC_CONT ; }

lxc_exec () { lxc exec $LXC_CONT $@ ; }
lxc_bash () { lxc exec $LXC_CONT -- su --login ubuntu ; }
lxc_bash_root () { lxc exec $LXC_CONT -- /bin/bash ; }
lxc_cp_from_container () { echo "file: lxc file pull instancename/path-in-container path-on-host
folder: lxc file pull -r instancename/path-in-container path-on-host"
}
# lxc_cp_to_container
lxc_storage () {
    lxc storage list
    lxc storage info default
}

lxc_mount_this () {
    cont_dir="/mnt/ros_rpi/"
    host_dir="$HOME/DATA/image/ros_rpi"
    lxc exec $LXC_CONT -- "mkdir -p $cont_dir"
    lxc config device add $LXC_CONT myhomedir disk source=$host_dir path=$cont_dir
    lxc config device show $LXC_CONT
}
lxc_umount_this () {
    cont_dir="/mnt/ros_rpi/"
    lxc config device remove $LXC_CONT $cont_dir
}


# to enable graphic X apps from inside of lxc running system
# more info: https://blog.simos.info/how-to-run-wine-graphics-accelerated-in-an-lxd-container-on-ubuntu/
lxc_config_remap_root () {
    lxc config set $LXC_CONT raw.idmap "both $UID 1000"
    lxc config device add $LXC_CONT X0 disk path=/tmp/.X11-unix/X0 source=/tmp/.X11-unix/X0
    lxc config device add $LXC_CONT Xauthority disk path=/home/ubuntu/.Xauthority source=/home/dd/.Xauthority
    lxc config device add $LXC_CONT mygpu gpu
    lxc config device set $LXC_CONT mygpu uid 1000
    lxc config device set $LXC_CONT mygpu gid 1000
    lxc restart $LXC_CONT
}

lxc_run_xclock () {
    lxc_exec -- /bin/bash -c "xclock";
}
