# Scripts and configurations for power management

## CPU undervolting

- Tool: `intel-undervolt`
    - GitHub: https://github.com/kitsunyan/intel-undervolt
    - RPM: https://fedora.pkgs.org/36/fedora-updates-x86_64/intel-undervolt-1.7-12.fc36.x86_64.rpm.html

- Configuration:
    - Copy `intel-undervolt.conf` to `/etc/intel-undervolt.conf`
    - Run `intel-undervolt apply`
    - Notes:
        - CPU and Cache offsets can be equal, always stable from my experience
        - `dmesg` may report a warning `msr: Write to unrecognized MSR 0x150 by intel-undervolt (pid: 3717).`. In future kernel versions, it may be necessary to configure the kernel module `msr` and set `msr.allow_writes=on` 

- Testing:
    - Use `intel-undervolt measure` to monitor CPU temperatures and power consumption
    - Use `intel_gpu_top` to monitor iGPU power consumption
        - In my personal experience, the savings are very small. Maybe not worthy to undervolt at all (_stability_ vs _power saves_ trade offs)
        - Provided by package [`igt-gpu-tools`](https://pkgs.org/search/?q=igt-gpu-tools)
    - Run `sysbench cpu --cpu-max-prime=10000000 --threads=8 run`
        - Note: this is a quick test, more itensive tests should be done to ensure stability.
    - Testing sleep/hibernation is also important

Undervolting alone reduces power consumption from 40-45W to 30-35W in the test above!

### Resources

- MSR warning: https://github.com/kitsunyan/intel-undervolt/issues/55

## PowerTOP

Quite handy tool to debug power consumption and also customise system settings to reduce overall power consumption.
- After undervolting, CPU using 4-5W when idle.
- After PowerTOP automatic tunning, consumption goes below 1W when idling.

**Problem**: I don't like the default PowerTOP auto tunning settings. My issue is that it enables auto-suspend for the USB port where I connect the Logitech USB receiver for my wireless mouse. Consequently, connection drops all the time. Other than that, the defaults are good.

**Solution**: PowerTOP can generate a report running `powertop --html=report.html`. The commands issued by the auto tunner are available in the reporting, allowing me to pick the ones I want! Next, I create a custom script with the desired tunning steps. The script is `tuneup.sh`. It is mostly copy-paste from PowerTOP report, expect the last lines where I created a custom solution to not disable the Logitech receiver. Basically it iterates over USB ports and skips it if it has a Logitech device connected to it. Not super fancy, but gets the job done for me and allows me to connect the receiver to any port I want.

**Setup**: The goal is to run the script on boot automatically. To achieve that, I decided to create a `systemd` service, `power_tune.service`.
1. Move script file to `opt/`: `# cp powertune.sh /opt/powertune.sh`
2. Move the service to `systemd` directory: `# cp powertune.service /etc/systemd/system/powertune.service`
3. Run the script once, for testing purposes
    1. `# systemctl start powertune.service`
    2. `# systemctl status powertune.service`
4. If service completed with success, enable it to run automatically on boot: `# systemctl enable powertune.service`

### Resources

- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/monitoring_and_managing_system_status_and_performance/managing-power-consumption-with-powertop_monitoring-and-managing-system-status-and-performance
- https://www.intel.com/content/www/us/en/developer/articles/tool/powertop-primer.html
- https://docs.fedoraproject.org/en-US/quick-docs/understanding-and-administering-systemd/
- https://www.freedesktop.org/software/systemd/man/systemd.service.html

## i915 parameters

TODO