# Fusée à la Framboise
[![build](https://github.com/kleo/fusee-framboise/actions/workflows/build.yml/badge.svg)](https://github.com/kleo/fusee-framboise/actions/workflows/build.yml)

Fusée à la Framboise is a Raspberry Pi OS image that loops Fusée Gelée over and over again. 

Includes [hekate v5.5.8 & Nyx v1.0.5](https://github.com/CTCaer/hekate/releases/tag/v5.5.7) and [Atmosphere fusee-primary 0.19.3](https://github.com/Atmosphere-NX/Atmosphere/releases/tag/0.19.3) payload images.

Also see [Fusée à la Alpestre](https://github.com/kleo/fusee-alpestre) for an Alpine Linux base image.

## Tutorial

### What you need

 * Raspberry Pi 3 B, Zero or Zero W
 * A power bank (500mA output works, but I'd recommend 1A)
 * A USB hub (no need for it to be powered)
 * A USB A -> C cable, for transmitting to the Switch. (**do not get an old/no-brand one, it may wreck your Switch or USB source** ([why?](https://pastebin.com/80QXsefE)))
 * An A -> MicroUSB cable, for powering the Pi.
 * A MicroUSB -> A cable, for USB output from the Pi. (one of these should come with a Pi Zero kit)

### Setup

 1. [Download a fusee-framboise image](https://github.com/kleo/fusee-framboise/releases), or [build one yourself](#building).
 2. Extract the release .img file, and flash it to your Pi's SD card. (We recommend [Etcher](https://etcher.io) for a flashing tool.)
 3. Plug in your USB Hub **before** you power on your Pi. ([why?](https://www.raspberrypi.org/forums/viewtopic.php?t=23205#p217196))
 4. Power on your Pi via your power bank.

### Usage

After your Pi has (hopefully) booted, you'll just need to plug in your Switch to the hub via the USB-A -> C cable, and enter RCM. The payload will be automatically executed.

### Demo

[![Fusée à la Framboise with Hekate 5.3.4](https://img.youtube.com/vi/CdMKe9dGHEk/hqdefault.jpg)](https://youtu.be/CdMKe9dGHEk)

## Building  

Learn more at [RPi-Distro/pi-gen](https://github.com/RPi-Distro/pi-gen)
