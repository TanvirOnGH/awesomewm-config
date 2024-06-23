# About

My [Awesome Window Manager](https://awesomewm.org) configuration. It's a highly customized setup focused on a clean, efficient, and visually appealing desktop experience.

> [!NOTE]  
> I'm using this [awesomewm](https://awesomewm.org) configuration on my [NixOS](https://nixos.org) systems, and you might notice some things that appear unusual, like the standard paths, e.g `/usr/share` equivalent for nix is `/run/current-system/sw/share` and for home-manager is `~/.local/state/home-manager/gcroots/current-home/home-path/share` on NixOS systems.
>
> Wallpapers aren't included for obvious reasons.
>
> This repository is not meant to be used as a whole, but rather as a reference for my own configuration. I do not recommend using it as is, as it is not meant to be used by anyone else. I do not provide any support for this repository. If you want to use it, you are on your own.

> [!TIP]  
> Use [LuaJIT](https://luajit.org) for best performance.

![Ruby Desktop](screenshots/rosybrown_desktop.png)

![Ruby Desktop Terminal Windows](screenshots/rosybrown_desktop_terminals.png)

## Installation

```bash
git clone https://github.com/TanvirOnGH/awesomewm-config.git ~/.config/awesome --recursive
```

## Misc screenshots

### Window Layouts

![Window Layouts](screenshots/layouts.png)

### Time-Calendar widget

![Time-Calendar bottom bar widget](screenshots/time_calendar_bar_widget.png)

### Window Titlebar

Mini:

![Window Titlebar Mini](screenshots/window_titlebar_mini.png)

Compact:

![Window Titlebar Compact](screenshots/window_titlebar_compact.png)

Full (default):

![Window Titlebar](screenshots/window_titlebar_full.png)

### Desktop Menu

![Desktop Menu](screenshots/desktop_menu.png)

### Window Menu

![Window Menu](screenshots/window_menu.png)

### Process List

![Process List](screenshots/process_list.png)

### Application Switcher

![Application Switcher](screenshots/application_switcher.png)

### Calendar

![Calendar](screenshots/calendar.png)

## Acknowledgements

[worron/awesome-config](https://github.com/worron/awesome-config) Original configuration that served as the foundation for this project.

[flex](https://github.com/TanvirOnGH/flex) extension module for providing a collection of visually consistent and functional widgets, layout enhancements, and utilities.

The AwesomeWM community for their excellent window manager and helpful resources.
