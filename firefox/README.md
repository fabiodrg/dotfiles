# Firefox settings

The `user.js` contains my personal settings for Firefox. It overrides the settings in `prefs.js`, which is managed by Firefox: contains the defaults, system-specific settings (not portable) and manual changes in `about:config`. The idea is using `user.js` to override generic settings, so that I can use it on different systems.

## Instructions

Simply copy the `user.js` file to the profile folder, somewhere in `~/.mozilla/firefox`. Each profile has its own directory and settings. To find my user identifier or folder, go to `about:support`.

## Hardware acceleration

To benefit from hardware acceleration, mainly video decoding, additional steps are needed.

- Packages needed to be installed, use links below:
    - https://fedoraproject.org/wiki/Firefox_Hardware_acceleration
    - https://wiki.archlinux.org/title/Firefox#Hardware_video_acceleration
- Configuration file `user.js` already sets the required Firefox settings
    - `media.ffmpeg.vaapi.enabled=true` seems enough as of Firefox 101
- Due to a bug, it is necessary to disable sandboxing for VA-API
    - `media.rdd-process.enabled` does not seem to work at all, leave the default
    - Workaround: set the environment variable `MOZ_DISABLE_RDD_SANDBOX=1`
        - I changed the `.desktop` file located in `.local/share/applications`
        - Alternative for system wide application: modify `/etc/environment` and add a line `MOZ_DISABLE_RDD_SANDBOX=1`

To ensure video decoding is working, use `intel_gpu_tool` while playing a random 4K video on YouTube. The `Video` engine should be under usage. CPU consumption should not spike during video playback.