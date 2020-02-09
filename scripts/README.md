# Scripts

## `kbd_sleep`

This script disables the keyboard slave device in X.org (also known as X Window System, X11, or just X). 

Why would you do that? Well, my purpose can be odd. I rarely shut down my laptop: wake up times range from one week to one month. This is an issue for me because I like to regularly clean my laptop to remove dust and oil from hands. I can't do it with my system awake unless I want to mess things up!

A possible solution would be to set the computer to sleep and disable any keypress events to up the system. That would be OK, but not suitable for me. I don't close the lid unless I need to move my laptop, therefore I am used to setting it to sleep using the OS interface or commands and awaking the system by pressing any key or the power button.

What's left? Like many keyboards have a built-in key to toggle the touchpad, I wished to simulate the same for the keyboard. As a result, I created a small script for systems working with `X.org` window systems. It takes advantage of the built-in `xinput` tool, which I assume is pre-installed on most systems.

Once I disable the keyboard, I need a way to enable it again later on without relying on it. My solution, for now, is to disable it temporarily. Just enough time to clean my keyboard.

### Usage

First, you need to get the IDs from the devices. In X.org you have master and slave devices. We are interested in the master keyboard device ID and one of its slaves that will be the keyboard itself.

```bash
⎡ Virtual core pointer                          id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ SYNA2B46:00 06CB:CD5F Mouse               id=12   [slave  pointer  (2)]
⎜   ↳ SYNA2B46:00 06CB:CD5F Touchpad            id=13   [slave  pointer  (2)]
⎜   ↳ Logitech M585/M590                        id=10   [slave  pointer  (2)]
⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
	↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
	↳ Video Bus                                 id=6    [slave  keyboard (3)]
	↳ Video Bus                                 id=7    [slave  keyboard (3)]
	↳ Power Button                              id=8    [slave  keyboard (3)]
	↳ Sleep Button                              id=9    [slave  keyboard (3)]
	↳ Integrated Camera: Integrated C           id=11   [slave  keyboard (3)]
	↳ Ideapad extra buttons                     id=14   [slave  keyboard (3)]
	↳ AT Translated Set 2 keyboard              id=15   [slave  keyboard (3)]
	↳ Logitech M585/M590                        id=16   [slave  keyboard (3)]
```

- Keyboard master: 3
- Keyboard slave: 15

Then simply run the script:

```bash
$ ./kbd_sleep [sleep]
```

The `sleep` argument is optional. It's the number of seconds the keyboard will be disabled. It defaults to 120 seconds.

### ToDo

- Think of a better solution. A user input for enabling the keyboard again instead of relying in time
- Automatically get the keyboard IDs
- Consider using `set-props` instead (requires single ID).
