ros_src () {
	ros_file="/opt/ros/foxy/setup.bash"
	echo "sourcing $ros_file"
	source $ros_file
}

ROS_WS_DIR="/home/ubuntu/ros2_ws/"
ROS_WS_FILE="${ROS_WS_DIR}/inst/setup.bash"

ros_src_ws1 () {
	ros_file="$ROS_WS_FILE"
	echo "sourcing $ros_file"
	source $ros_file
}

ros_src
ros_src_ws1

ros_build () {
	cd $ROS_WS_DIR
	colcon build
	ros_src_ws1
}


