# KDE configuration files

This folder contains KDE-specific scripts and configuration files

## Keyboard shortcuts

### Screenshot custom shortcuts

I don't like the default keyboard shortcuts for `Spectacle` in KDE because they always launch the GUI. It does not suit my workflow.

After inspecting the CLI options for `Spectacle`, I came up with the following shortcuts:
- Current desktop/monitor (clipboard): `Print`
- Full desktop (clipboard): `Ctrl` + `Shift` + `Print`
- Retangular region (clipboard): `Shift` + `Print`
- Current active window (clipboard): `Ctrl` + `Print`
    - I can't set `Alt` + `Print`, which is the standard combination for this. It is recognized as `SysReq` [1]
- Retangular region (GUI): `Meta` + `Shift` + `Print`
- Full desktop (GUI): `Meta` + `Print`
    - From the GUI I can retake the screenshot if needed, thus I dont see the need to create a shortcut for active window, full desktop vs current desktop, etc. I dont take such screenshots often
    - The advantage of the GUI is mainly to make annotations. Spectacle is quite solid and feature-packaed nowadays!

### Automation? Is it possible?

- There are two relevant configuration files: `~/.config/kglobalshortcutsrc` and `~/.config/khotkeysrc`
- Custom shortcuts are stored in the second file, but the first also has references to it, namely UUIDs for triggers (keys combination), description, etc.
- Ideally I would like to create a script that automatically configures the shortcuts for me, but that seems complicated for custom shortcuts at least, mainly because I need to manage the two configuration files...

```
[khotkeys]
{0bf0fe6a-b42c-4c22-b73b-f57fd295f5dc}=Meta+Shift+Print,none,Retangular Region (GUI)
{1d313b1a-0fcd-40f9-bcc2-13093c534508}=Ctrl+Print,none,Current Window (clipboard)
{338cfde7-ee61-4f00-b1b8-a5f4685da3d1}=Print,none,Desktop (clipboard)
```

```
[Data_1_4]
Comment=Select retangular region and open GUI
Enabled=true
Name=Retangular Region (GUI)
Type=SIMPLE_ACTION_DATA

[Data_1_4Actions]
ActionsCount=1

[Data_1_4Actions0]
CommandURL=spectacle -g -c -r
Type=COMMAND_URL

[Data_1_4Conditions]
Comment=
ConditionsCount=0

[Data_1_4Triggers]
Comment=Simple_action
TriggersCount=1

[Data_1_4Triggers0]
Key=Meta+Shift+Print
Type=SHORTCUT
Uuid={0bf0fe6a-b42c-4c22-b73b-f57fd295f5dc}
```

- Thus, for now the manual approach is to open Settings > Shortcuts > Custom shortcuts and click Edit button to import the `hhotkeys` file
    - The `screenshots.khotkeys` contains the custom shortcuts for screenshotting with KDE Spectacle, aforementioned

## Resources 

1. https://wiki.archlinux.org/title/Keyboard_shortcuts#Kernel_(SysRq)