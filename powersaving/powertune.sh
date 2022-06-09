#!/bin/bash
#VM writeback timeout
echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs';
#Enable SATA link power management for host3
echo 'min_power' > '/sys/class/scsi_host/host3/link_power_management_policy';
#Enable SATA link power management for host1
echo 'min_power' > '/sys/class/scsi_host/host1/link_power_management_policy';
#Enable SATA link power management for host4
echo 'min_power' > '/sys/class/scsi_host/host4/link_power_management_policy';
#Enable SATA link power management for host2
echo 'min_power' > '/sys/class/scsi_host/host2/link_power_management_policy';
#Enable SATA link power management for host0
echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy';
#NMI watchdog should be turned off
echo '0' > '/proc/sys/kernel/nmi_watchdog';
#Autosuspend for USB device USB Receiver [Logitech]
# echo 'auto' > '/sys/bus/usb/devices/1-3/power/control';
#Runtime PM for I2C Adapter i2c-3 (i915 gmbus dpc)
echo 'auto' > '/sys/bus/i2c/devices/i2c-3/device/power/control';
#Runtime PM for I2C Adapter i2c-4 (i915 gmbus misc)
echo 'auto' > '/sys/bus/i2c/devices/i2c-4/device/power/control';
#Runtime PM for I2C Adapter i2c-2 (i915 gmbus dpb)
echo 'auto' > '/sys/bus/i2c/devices/i2c-2/device/power/control';
#Runtime PM for I2C Adapter i2c-5 (i915 gmbus dpd)
echo 'auto' > '/sys/bus/i2c/devices/i2c-5/device/power/control';
#Runtime PM for disk sda
echo 'auto' > '/sys/block/sda/device/power/control';
#Runtime PM for PCI Device Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/power/control';
#Runtime PM for port ata1 of PCI device: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata1/power/control';
#Runtime PM for port ata2 of PCI device: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata2/power/control';
#Runtime PM for port ata3 of PCI device: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata3/power/control';
#Runtime PM for port ata4 of PCI device: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata4/power/control';
#Runtime PM for port ata5 of PCI device: Intel Corporation Cannon Lake Mobile PCH SATA AHCI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:17.0/ata5/power/control';
#Runtime PM for PCI Device Intel Corporation Xeon E3-1200 v5/v6 / E3-1500 v5 / 6th/7th/8th Gen Core Processor Gaussian Mixture Model
echo 'auto' > '/sys/bus/pci/devices/0000:00:08.0/power/control';
#Runtime PM for PCI Device Intel Corporation Cannon Lake PCH USB 3.1 xHCI Host Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:14.0/power/control';
#Runtime PM for PCI Device Intel Corporation Device a30d
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.0/power/control';
#Runtime PM for PCI Device Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Thermal Subsystem
echo 'auto' > '/sys/bus/pci/devices/0000:00:04.0/power/control';
#Runtime PM for PCI Device Intel Corporation UHD Graphics 630 (Mobile)
echo 'auto' > '/sys/bus/pci/devices/0000:00:02.0/power/control';
#Runtime PM for PCI Device NVIDIA Corporation GP107M [GeForce GTX 1050 Mobile]
echo 'auto' > '/sys/bus/pci/devices/0000:01:00.0/power/control';
#Runtime PM for PCI Device Intel Corporation Cannon Lake PCH SPI Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.5/power/control';
#Runtime PM for PCI Device Intel Corporation Cannon Lake PCH Shared SRAM
echo 'auto' > '/sys/bus/pci/devices/0000:00:14.2/power/control';
#Runtime PM for PCI Device Intel Corporation Cannon Lake PCH cAVS
echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.3/power/control';
#Runtime PM for PCI Device Intel Corporation Dual Band Wireless-AC 3165 Plus Bluetooth
echo 'auto' > '/sys/bus/pci/devices/0000:07:00.0/power/control';
#Runtime PM for PCI Device Intel Corporation 8th Gen Core 4-core Processor Host Bridge/DRAM Registers [Coffee Lake H]
echo 'auto' > '/sys/bus/pci/devices/0000:00:00.0/power/control';
#Runtime PM for PCI Device Intel Corporation Cannon Lake PCH Thermal Controller
echo 'auto' > '/sys/bus/pci/devices/0000:00:12.0/power/control';
#Runtime PM for PCI Device Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller
echo 'auto' > '/sys/bus/pci/devices/0000:08:00.0/power/control';
#Runtime PM for PCI Device Samsung Electronics Co Ltd NVMe SSD Controller SM981/PM981/PM983
echo 'auto' > '/sys/bus/pci/devices/0000:06:00.0/power/control';

# Wake-on-lan status for device enp8s0
echo 'disabled' > '/sys/class/net/enp8s0/device/power/wakeup';
# Wake-on-lan status for device wlp7s0
echo 'disabled' > '/sys/class/net/wlp7s0/device/power/wakeup';
# =============================================================================
# Disable wakeup feature for some USB devices
# =============================================================================
# My main goal is to disable wakeup on the usb port with my mouse connected. E.g.
# if I suspend my laptop and I move my wireless mouse it will awake the laptop
# because the usb port where it's connected, by default, has wakeup feature
# enabled, i.e. the USB port is in a sleep state and when the connected devices
# transmits input it will awake the system
# **HOW**
# Slightly hard-coded. My mouse manufacturer is Logitech, so I loop through the
# the usb devices connected to USB HUB 1, which includes all USB type-A ports,
# webcam, etc. I find the port that has a device which manufacturer is Logitech,
# then I disable the wakeup power-management feature.
# **REFERENCES**
# https://www.kernel.org/doc/html/latest/driver-api/usb/power-management.html

# location for USB HUB1 devices
USB_HOST_DIR="/sys/bus/usb/devices/usb1/*"
# mouse manufacturer name
MOUSE_MFR="Logitech"
# loop through usb devices with a manufacturer file
for dev in $USB_HOST_DIR/manufacturer
do
	if [ "$(cat $dev)" == "$MOUSE_MFR" ]; then
		# remove the 'manufacturer' from the file path
		dev_root_dir=${dev%/*}
		# construct the directory for wakeup config file
		wakeup_file=$dev_root_dir/power/wakeup
		# change file configuration
		echo 'disabled' > $wakeup_file
	fi
done