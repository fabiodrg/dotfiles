# Hardcoded IDs for the Keyboard master device, and keyboard slave device
# The IDs are retrivied from `$ xinput list`
KBD_MASTER_ID=3
KBD_SLAVE_ID=15

# Disable the keyboard slave by removing it from the master device
xinput --float $KBD_SLAVE_ID
# Re-add the keyboard slave to the master keyboard, thus enabling it
sleep 5 ; xinput --reattach $KBD_SLAVE_ID $KBD_MASTER_ID
