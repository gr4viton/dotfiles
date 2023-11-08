think_cam_enable() {
    sudo systemctl enable v4l2-relayd.service
}
think_cam_restart() {
    sudo systemctl restart v4l2-relayd.service
}
think_cam_status() {
    sudo systemctl status v4l2-relayd.service
}
