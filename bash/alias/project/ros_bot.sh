# __ros__
# ROS robotic operating system

ros_src_base () {
	ros_file="/opt/ros/foxy/setup.bash"
	echo "sourcing $ros_file"
	source $ros_file
}

ROS_WS_DIR="/home/ubuntu/ros2_ws/"
ROS_WS_FILE="${ROS_WS_DIR}/install/setup.bash"

folderize ros "/home/ubuntu/ros2_ws/"
folderize rosp "${dirros}src/my_python_pkg/"
folderize ross "${dirros}src/my_python_pkg/my_python_pkg"

viros () {
    vim $(agp $dirross)
}
ross_black () {
    black $dirross
}


ros_src_ws1 () {
	ros_file="$ROS_WS_FILE"
	echo "sourcing $ros_file"
	source $ros_file
}

ros_build () {
	cd $ROS_WS_DIR
	colcon build
	ros_src_ws1
}

ros_src () {
    ros_src_base
    ros_src_ws1
}

ros_src

ros_run_1 () {
    ros2 run my_python_pkg test
}

ros_run_butled () {
    ros2 launch my_python_pkg button_led.launch.py
}

ros_run_butmot () {
    ros2 launch my_python_pkg button_motor.launch.py
}

ros_run_demo () {
    ros2 launch my_python_pkg demo.launch.py
}


ros_dep_install () {
    cdros
    rosdep install --ignore-src --from-paths src/
}
