# termux executable

dtermux_shortcuts="/data/data/com.termux/files/home/.shortcuts/"
dtermux_tasks="${dtermux_shortcuts}tasks"

termux_create_widget_script_dirs () {
	mkdir -p $dtermux_shortcuts
	mkdir -p $dtermux_tasks
}
