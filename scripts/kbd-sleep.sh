# How long the keyboard should be disabled (seconds)
SLEEP_TIME=120

# Parse user argument, if any
if [[ $# -eq 1 ]]; then
	# Override default sleep time with user input time
	SLEEP_TIME=$1
fi

# Get the device ID for the keyboard
KBD_ID=$(xinput list --id-only 'AT Translated Set 2 keyboard')

# Disable the keyboard
xinput disable $KBD_ID

# Waiting period
sleep $SLEEP_TIME

# Re-enable the keyboard device
xinput enable $KBD_ID
