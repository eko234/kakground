# KAKGROUND

why would I do it outside of kakoune?
kakground allows you to select a directory and
dynamically change backgrounds asyncronously
just navigate the buffer and the line you where
you stand will be set as the new background

## Command
  - `kakground` takes one param, the directory with the backgrounds from whichi you will choose and it prints them in a new buffer with the hooks needed to easily change backgrounds


## Option
  - `kakground` provides an option to define the command used to change the wallpaper, for sway users you would like to use something like 'xargs -n 1 -I {} swaymsg output "*" background {} fill', the default option would work for any system using feh, but the logic is the same, the file es piped to the command, thus the use of `xargs`
