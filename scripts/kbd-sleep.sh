# Hardcoded IDs for the Keyboard master device, and keyboard slave device
# The IDs are retrivied from `$ xinput list`
KBD_MASTER_ID=3
KBD_SLAVE_ID=15

if [[ $# -eq 1 ]]; then
	# Retrieve the sleep time provided by user
	SLEEP_TIME=$1
else
	# if no argument is provided, then default to 120 seconds
	SLEEP_TIME=120
fi

# Disable the keyboard slave by removing it from the master device
xinput --float $KBD_SLAVE_ID
# Re-add the keyboard slave to the master keyboard, thus enabling it
sleep $SLEEP_TIME ; xinput --reattach $KBD_SLAVE_ID $KBD_MASTER_ID
