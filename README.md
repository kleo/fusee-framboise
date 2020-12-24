# Fusée à la Framboise

Fusée à la Framboise is a Raspberry Pi OS image that loops Fusée Gelée over and over again. 

Includes [Hekate](https://github.com/CTCaer/hekate/) and [Atmosphere](https://github.com/Atmosphere-NX/Atmosphere) fusee-primary payload images.

## Tutorial

### What you need

 * Raspberry Pi 3 B, Zero or Zero W
 * A power bank (500mA output works, but I'd recommend 1A)
 * A USB hub (no need for it to be powered)
 * A USB A -> C cable, for transmitting to the Switch. (**do not get an old/no-brand one, it may wreck your Switch or USB source** ([why?](https://pastebin.com/80QXsefE)))
 * An A -> MicroUSB cable, for powering the Pi.
 * A MicroUSB -> A cable, for USB output from the Pi. (one of these should come with a Pi Zero kit)

### Setup

 1. [Download a fusee-framboise image](https://github.com/kbeflo/fusee-framboise/releases), or [build one yourself](#building).
 2. Extract the release .zip file, and flash it to your Pi's SD card. (We recommend [Etcher](https://etcher.io) for a flashing tool.)
 3. Plug in your USB Hub **before** you power on your Pi. ([why?](https://www.raspberrypi.org/forums/viewtopic.php?t=23205#p217196))
 4. Power on your Pi via your power bank.

### Usage

After your Pi has (hopefully) booted, you'll just need to plug in your Switch to the hub via the USB-A -> C cable, and enter RCM. The payload will be automatically executed.

### Demo

[![Fusée à la Framboise with Hekate 5.3.4](https://img.youtube.com/vi/CdMKe9dGHEk/hqdefault.jpg)](https://youtu.be/CdMKe9dGHEk)

### Changing the payload

[Fusée Gelée payload list](https://wiki.gbatemp.net/wiki/List_of_Switch_payloads)

To change the payload, you can do one of the following methods: (they need `sudo`)
 * Replace `fusee.bin` in `/etc/fusee-launcher/`. (recommended)
 * Copy another payload into `/etc/fusee-launcher/`, change `fusee.bin` in `/etc/fusee-launcher/modchipd.sh` to the new payload's filename, and `systemctl restart fusee-launcher` (or `reboot`).

## Building  

Learn more at [RPi-Distro/pi-gen](https://github.com/RPi-Distro/pi-gen)
