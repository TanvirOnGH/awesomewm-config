#!/bin/sh

# <https://www.freedesktop.org/wiki/Software/Xephyr>
# <https://wiki.archlinux.org/title/Xephyr>

# Constants
HEIGHT="1920"
WIDTH="1080"
DISPLAY_=":1"
EXECUTABLE="awesome"

display_usage() {
	echo "Invalid option. Usage: $0 [start | stop] [xephyr | awesome]"
}

start_xephyr() {
	Xephyr -br -ac -noreset -screen "${HEIGHT}x${WIDTH}" "$DISPLAY_" &
	echo "Xephyr started."
}

start_awesome() {
	DISPLAY="$DISPLAY_" "$EXECUTABLE"
	echo "Awesome started."
}

stop_xephyr() {
	pkill Xephyr
	echo "Xephyr stopped."
}

if [ "$1" = "start" ]; then
	if [ "$2" = "xephyr" ]; then
		start_xephyr
	elif [ "$2" = "awesome" ]; then
		start_awesome
	else
		display_usage
	fi
elif [ "$1" = "stop" ]; then
	if [ "$2" = "xephyr" ]; then
		stop_xephyr
	else
		display_usage
	fi
else
	display_usage
fi
