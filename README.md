<div align="center"><img width="350" height="350" src="pictures/nixoslogowithtext.png"></div>
<h1 align="center">NixOS & Hyprland Configuration</h1>

<div align="center">
<img src="https://img.shields.io/static/v1?label=Hyprland&message=Unstable&style=flat&logo=hyprland&colorA=24273A&colorB=8AADF4&logoColor=CAD3F5"/>
<img src="https://img.shields.io/badge/NixOS-Unstable-informational.svg?style=flat&logo=nixos&logoColor=CAD3F5&colorA=24273A&colorB=8AADF4">
</div>


## 📖 About

This repository contains my NixOS Linux configuration with the Hyprland window manager. 

I use Nixos with Flakes & Home Manager.

It also includes my config for all my programs, as I use Nix to manage all my config files via home manager.

This includes my Emacs, Firefox, Zsh, and foot terminal configs, as well as configs for programs adjacent to Hyprland such as Waybar, Rofi, dunst, etc. All wrapped up neatly in one NixOS config!

## 🌟 Showcase

TODO: Add screenshots
TODO: Add gif eventually

![Screenshot 1](home/Pictures/Screenshots/screenshot-1.png)
![Screenshot 2](home/Pictures/Screenshots/screenshot-2.png)

## 🔧 Components

| Component        | Version/Name                         |
|------------------|--------------------------------------|
| Distro           | NixOS                                |
| Shell            | Zsh                                  |
| Display Server   | Wayland                              |
| WM (Compositor)  | Hyprland                             |
| Bar              | Waybar                               |
| Notification     | Dunst                                |
| Launcher         | Rofi-Wayland                         |
| Editor           | Emacs                                |
| Terminal         | Foot                                 |
| Night Gamma      | Gammastep - To install               |
| Fetch Utility    | Neofetch                             |
| Theme            | Base16                               |
| Icons            | TBD                                  |
| Font             | JetBrains Mono + Nerd Font Patch     |
| Player           | MPD/MPC                              |
| File Browser     | TBD                                  |
| Internet Browser | Firefox                              |
| Mimetypes        | MPV, Imv, Zathura  - To install      |
| Image Editor     | Swappy - To install                  |
| Screenshot       | Grim + Slurp - To install            |
| Recorder         | Wf-recorder - To install             |
| Clipboard        | Wl-clipboard + Cliphist - To install |
| Idle             | Swayidle - To install                |
| Lock             | Swaylock - To install                |
| Logout menu      | Wlogout - To install                 |
| Wallpaper        | Wpaperd                              |
| Graphical Boot   | Plymouth                             |
| Display Manager  | Greetd + Tuigreet                    |

This is a list of all the noteworthy programs. There are many more utilites and programs installed that aren't listed. Check the home.nix and configuration.nix pkgs to see them all.

## ✨ Features

- 🔄 **Reproducible**: Built on NixOS, this configuration can be effortlessly reproduced on other machines, ensuring a consistent setup.

- 🖌️ **Consistent**: Nearly every component has been styled with base16 colors so I can change my base16 theme and all programs are themed in a cohesive way.

- ✅ **Complete**: This system is equipped with a wide range of components and utilities, akin to the completeness of operating systems like MacOS or Windows.

- 🪶 **Lightweight**: Using only a window manager and lightweight utilities keeps memory usage low and the system unbloated.

- 🎨 **Customizable**: By changing the base16 theme most programs will update to use that colorscheme. Config wise all programs are and can be configured via home manager in one place. 

## 🚀 Installation

1. Download and Install NixOS from the [official site](https://nixos.org/download).
2. Clone the repo, change your system hostname in flake.nix and configuration.nix
3. # Run 'nixos-rebuild --flake .#your-hostname'

## ⌨️ Keybindings

I try to use Emacs keys as much as possible as it is my favorite software :)

### Main
TODO: Fill in my keybinds

| Key Combination      | Action                                            |
|----------------------|---------------------------------------------------|
| ALT + R              | Resize windows mode                               |
| ALT + M              | Move windows mode                                 |
| SUPER + N, P         | Cycle window focus                                |
| SUPER + 1..0         | Change workspace                                  |
| SUPER + SHIFT + 1..0 | Move window to workspace                          |
| SUPER + SHIFT + Q    | Kill active window                                |
| SUPER + SHIFT + F    | Toggle floating window                            |
| SUPER + CTRL + F     | Toggle full-screen                                |
| SUPER + SHIFT + O    | Toggle split                                      |
| SUPER + SHIFT + M    | Exit from hyprland                                |
| SUPER + T            | Launch wezTerm                                    |
| SUPER + D            | Launch rofi -drun                                 |
| SUPER + B            | Launch qutebrowser                                |
| SUPER + SHIFT + B    | Launch brave                                      |
| SUPER + F            | Launch thunar                                     |
| SUPER + ESCAPE       | Launch wlogout                                    |
| SUPER + SHIFT + L    | Swaylock                                          |
| SUPER + SHIFT + S    | Take screenshot                                   |
| SUPER + E            | Launch swappy to edit last taken screenshot       |
| SUPER + R            | Record screen area (MP4)                          |
| SUPER + SHIFT + R    | Record screen area (GIF)                          |
| SUPER + C            | Color picker                                      |
| SUPER + V            | Launch clipboard menu (rofi -dmenu)               |
| SUPER + X            | Launch clipboard deletion item menu (rofi -dmenu) |
| SUPER + SHIFT + X    | Clear clipboard                                   |
| SUPER + U            | Launch bookmark menu (rofi -dmenu)                |
| SUPER + SHIFT + U    | Add text from clipboard to bookmark               |
| SUPER + CTRL + U     | Launch bookmark deletion item menu (rofi -dmenu)  |
| SUPER + SHIFT + A    | Toggle airplane mode                              |
| SUPER + SHIFT + N    | Toggle notifications                              |
| SUPER + SHIFT + Y    | Toggle bluetooth                                  |
| SUPER + SHIFT + W    | Toggle wifi                                       |
| SUPER + P            | Toggle play-pause player                          |
| SUPER + ]            | Player next track                                 |
| SUPER + [            | Player previous track                             |

All other keybindings are in `/home/.config/hypr/hyprland.conf` in the bind section. 
All system zsh scripts are located in the TBD directory.

## 📜 License

This project is licensed under the GPL3 License - see the [LICENSE](LICENSE) file for details. 

# More

## Future Ideas

### Interesting

Things to look at.
- https://grahamc.com/blog/erase-your-darlings/

nix-on-droid
Clipboard-jh
avizo (macos like sound/brightness popup)


### For Visitors

These configurations are obviously meant for my personal use.

I wrote this mostly from scratch, as an exercise to improve my understanding of the Nix and NixOS ecosystem as well as about linux, window managers and software in general.

However, I try to structure it well and document options and my decisions extensively via comments (mainly for my own sake, so it's easily maintainable and I won't have to wonder why I did something in a particular way some time in the future.).

So, this project might be a useful resource if you're working on your own config, so feel free to look through it, copy whatever you want, steal whatever, anything that helps!

If you're just starting with NixOS, I'd suggest you look at <https://github.com/Misterio77/nix-starter-configs>.

### References

I used elements and inspiration from these resources. 

- https://github.com/Misterio77/nix-starter-configs
- https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles


## Structure 
TODO: Add my structure in the format below...
```
project
│   README.md
│   flake.nix (entry to configuration)
│   ...
│
└───emacs (doom emacs config)
│   │   install (install script that symlinks emacs config into place)
│   │   file012.txt
│   │   ...
│
└───home (default home-manager configs)
│   │   ...
│
└───machines (hardware configuration for all machines this config runs on)
│   └───ascent (ephemeral matrix host)
│   │   ...
│   └───DovDev (daily driver laptop)
│   │   ...
│   └───DovDevUbuntu (nix on ubuntu)
│   │   ...
│   └───nixosvm (base config for running nixos on a virtualbox vm)
│   │   ...
│
└───modules (custom nixos modules)
│   │   ...
│
└───overlays
│   │   default.nix (default package overides)
│
└───pkgs (custom packages)
│   │   ...
│
└───users
│   └───$user
│   │   default.nix (called in the system context)
│   │   home.nix (called in the home-manager context)
```
