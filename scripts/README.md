# Scripts

## `kbd-sleep`

This script disables the keyboard slave device in X.org system (also known as X Window System, X11, or just X). 

Why would you do that? Well, my purpose is a bit odd. I rarely shut down my laptop, with wake-up times ranging from one week to one month. It is an issue for me because I like to regularly clean my laptop (almost daily), and obviously pressing random keys can trigger unwanted actions...

A possible solution would be setting the computer to sleep or hibernate and disable wake-up events on keypress. So I would sleep on the computer, clean it, close the lid, open the lid, voila. Meh! Having to close and open the lid stresses the hinges and screen unecessarially. Besides, I would have to do that every time I want to awake the computer; I only close the lid for carrying the laptop around.

So, most laptops have a built-in key to toggle the touchpad. So, why not do the same for the keyboard? I lack a dedicated key for that, however. But running a script that toggles the keyboard (via GUI with the mouse) or that disables the keyboard for a given amount of time would do the trick for me.

As a result, I created a small script for systems running `X.org` systems, taking advantage of the `xinput` tool for configuring all X devices (mouse, touchpad, touchscreen, keyboard, etc.). See [https://wiki.archlinux.org/title/Xorg#Input_devices](https://wiki.archlinux.org/title/Xorg#Input_devices).

### ToDo

- Think of a better solution. A user input for enabling the keyboard again instead of relying in time
