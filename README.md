# What is this?

This repository is a Nix flake containing a NixOS virtual machine you can use to test ONLYOFFICE DesktopEditors with good font support, as implemted in Nixpkgs PR [526315](https://github.com/NixOS/nixpkgs/pull/526315).

The virtual machine is *super* minimalist, only providing onlyoffice, a terminal, and labwc as a Wayland compositor. A sample document is provided (in the `Documents` directory).

![screenshot](screenshot.png)

# Getting started

## How to build the virtual machine

To build the NixOS virtual machine, run:

```
nixos-rebuild build-vm --flake github:emmanuelrosa/onlyoffice4nixos#onlyoffice-vm
```

You should end up with a symlink in your working directory.

## How to use the virtual machine

To run the Qemu/KVM virtual machine, run:

```
./result/bin/run-nixos-vm
```

The VM should automatically log you in as *johngalt*, but in case you need the password, it's *onlyoffice*.

Once logged in, you can get access to onlyoffice using the menu on the bottom left of the screen, or by rlight-clicking on the desktop.

To shut down, use the virtual machine's menu; The bar's shutdown menu doesn't work.

## How to clean up after the virtual machine

Aside from the symlink mentioned earlier, the virtual machine will create a nixos.qcow2 file. Once you're done with the virtual machine, you can delete both, the symlink (`result`) and the disk image (`nixos.qcow2`).

# What's included?

The following is a non-exhaustive list of what's included in the virtual machine. It's not much since its only purpose is for testing onlyoffice font support on NixOS.

## Programs

- Terminal: alacritty
- onlyoffice (desktop editors) 
- labwc
- labwc-menu-generator
- swaybg
- sfwbar
- greetd
- tuigreet 

## Fonts

- NotoSansCJK-VF
- texgyreadventor
- texgyrebonum
- texgyrechorus
- texgyreheros
- texgyreheroscn
- texgyrepagella
- texgyreschola
- texgyretermes
- unifont
- DejaVuMathTeXGyre
- DejaVuSans
- DejaVuSerif
- FreeMono
- FreeSans
- FreeSerif
- LiberationMono
- LiberationSans
- LiberationSerif
- LiberationSerif
- LiberationSerif
- LiberationSerif
- NotoColorEmoji
