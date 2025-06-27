# Webcam Config

- Script to setup the webcam settings using `v4l2`
- A udev rule to apply the configuration automatically everytime the webcam is attached to the computer

# Setup

```bash
# copy the script to user local folder with binaries
# NOTE: if path is changed, updated udev rule (hardcoded)
cp logi-c920-config ~/.local/bin


# Move the udev rule
sudo cp 90-logi-c920.rules /etc/udev/rules.d/
```

To ensure it works:
1. Detach & attach the webcam from USB port
2. Run `v4l2 --all` and see if the configured options were applied
