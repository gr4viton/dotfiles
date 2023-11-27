# __think__ __x1__

think_cam_enable() {
    sudo systemctl enable v4l2-relayd.service
}
think_cam_restart() {
    sudo systemctl restart v4l2-relayd.service
}
think_cam_status() {
    sudo systemctl status v4l2-relayd.service
}

think_touchscreen_disable () {
    xinput disable 19
}
think_touchscreen_enable () {
    xinput enable 19
}
