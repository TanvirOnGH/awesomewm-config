#!/bin/bash
# shellcheck disable=SC2173,SC2034

: '
A short Xephyr+Awesome wrapper that:
    - watches files with a debounced auto-reload on changes
    - handles tray through stalonetray
    - passes stdin/stdout through for logs and stuff like https://github.com/slembcke/debugger.lua

Run it with the current working directory where your rc.lua is (or edit the file accordingly). 
'

create_temp_dirs() {
	TMP="$(mktemp -d)"
	LOG="$TMP/stdout.log"
	LOG_ERROR="$TMP/stderr.log"
}

init_logging() {
	truncate --size 0 "$LOG" "$LOG_ERROR"
	tail -f "$LOG" >/dev/stdout &
	tail -f "$LOG_ERROR" >/dev/stderr &
}

setup_traps() {
	trap 'cleanup' SIGINT SIGTERM EXIT SIGKILL
}

cleanup() {
	rm -r "$TMP"
	[ -n "$(jobs -p)" ] && kill "$(jobs -p)" 2>/dev/null
}

start_xephyr() {
	DP_NUM=1
	DP=":$DP_NUM"
	ln -s "$(pwd)" "$TMP/awesome"
	Xephyr "$DP" -s 10000 -ac -noreset -screen 1280x720 >"$LOG" 2>"$LOG_ERROR" &
}

wait_for_xephyr() {
	while [ ! -e /tmp/.X11-unix/X${DP_NUM} ]; do
		sleep 0.1
	done
}

start_awesome() {
	export DEBUG="true"
	export XDG_CONFIG_HOME="$TMP"
	export DISPLAY="$DP.0"
	awesome -c "$TMP/awesome/rc.lua" >"$LOG" 2>"$LOG_ERROR" &
	WM_PID="$!"
}

monitor_changes() {
	local interval=1
	local limit
	limit=$(date +"%s")
	limit=$((limit + interval))
	inotifywait -r -m -e close_write --exclude 'index.lock|run.sh|.git' . | while read -r dir events f; do
		if [ "$(date +"%s")" -ge "$limit" ]; then
			limit=$(date +"%s")
			limit=$((limit + interval))
			echo "Changed '$f'. Reloading... " >"$LOG"
			kill -HUP "$WM_PID"
		else
			echo "Waiting ${interval}s..." >"$LOG"
		fi
	done
}

main() {
	create_temp_dirs
	init_logging
	setup_traps
	start_xephyr
	wait_for_xephyr
	start_awesome
	monitor_changes
}

main "$@"
