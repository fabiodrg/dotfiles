# Linux scripts

## Bash

My configuration for bash, so far, only plays with the `PS1` variable. I changed it in order to show the current `git` branch when inside a `git` repository. **It has some issues!** Moreover, when the branch is `master` the text blinks, which I thought it would be cool idea to warn me and think twice before committing, however this would require to clear the console everytime I switch between branches (otherwise, if I switch from `master` to any other branch, every previous terminal associated with master keeps blinking the text `master`).

**Partial configuration file:** [.bashrc](.bashrc)

## Intel Undervolt

Configuration for undervolting my laptop's Intel CPU. This makes power consumption more efficient and keeps the laptop cooler.

Requires the [`intel-undervolt`](https://aur.archlinux.org/packages/intel-undervolt/) tool.

**Configuration file:** [intel-undervolt.conf](intel-undervolt.conf)

## Tmux

The amazing `tmux` for letting me manage multiple terminal sessions inside the same console window!

**Configuration file:** [.tmux.conf](.tmux.conf)

## Vim

Still a very basic configuration for `vim`. Still digging it!

My current theme is `gruvbox`.

**Configuration file:** [.vimrc](.vimrc)
