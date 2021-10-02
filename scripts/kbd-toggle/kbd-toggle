# Get the device ID for the keyboard
DEVICE_NAME='AT Translated Set 2 keyboard'
KBD_ID=$(xinput list --id-only "$DEVICE_NAME")

# Enable the keyboard device
function kbd_enable() {
	xinput enable $KBD_ID
	notify-send -t 0 \
		-i input-keyboard-virtual-on \
		-c "device.added" \
		"Keyboard enabled" \
		"Run script to toggle the keyboard state and disable it"
}

# Disable the keyboard device
function kbd_disable() {
	xinput disable $KBD_ID
	notify-send -t 0 \
		-i input-keyboard-virtual-off \
		-c "device.removed" \
		"Keyboard disabled" \
		"Run script to toggle the keyboard state and enable it"

}

# Get current keyboard state, i.e. enabled or disabled
function kbd_get_state() {
	local state=$(xinput list-props "$DEVICE_NAME" | grep "Device Enabled" | awk '{ print $4 }')
	echo $state
}

# Temporarially disable the keyboard for a period of time
function kbd_tmp_sleep() {
	kbd_disable
	sleep $1
	kbd_enable
}

# Toggle the keyboard state, i.e. if it is disabled then enable it and vice versa
function kbd_state_toggle() {
	if [ $(kbd_get_state) -eq 1 ]; then
		kbd_disable
	else
		kbd_enable
	fi
}

# If has single argument, assume its the elapse time
if [[ $# -eq 1 ]]; then
	kbd_tmp_sleep $1
else
	kbd_state_toggle
fi
