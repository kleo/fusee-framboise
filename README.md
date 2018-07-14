# Fusée à la Framboise

Fusée à la Framboise is a Raspbian image that loops Fusée Gelée over and over again.

## Tutorial

### What you need

 * A Pi Zero (W)
 * A power bank (500mA output works, but I'd recommend 1A)
 * A USB hub (no need for it to be powered)
 * A USB A -> C cable, for transmitting to the Switch. (**do not get an old/no-brand one, it may wreck your Switch or USB source** ([why?](https://pastebin.com/80QXsefE)))
 * An A -> MicroUSB cable, for powering the Pi.
 * A MicroUSB -> A cable, for USB output from the Pi. (one of these should come with a Pi Zero kit)

### Setup

 1. [Download a fusee-framboise image](https://github.com/moriczgergo/fusee-framboise/releases), or [build one yourself](#building).
 2. Extract the release .zip file, and flash it to your Pi's SD card. (We recommend [Etcher](https://etcher.io) for a flashing tool.)
 3. Plug in your USB Hub **before** you power on your Pi. ([why?](https://www.raspberrypi.org/forums/viewtopic.php?t=23205#p217196))
 4. Power on your Pi via your power bank.
 
### Usage

After your Pi has (hopefully) booted, you'll just need to plug in your Switch to the hub via the USB-A -> C cable, and enter RCM. The payload will be automatically executed.

### Changing the payload

To change the payload, you can do one of the following methods: (they need `sudo`)
 * Replace `fusee.bin` in `/etc/fusee-launcher/`. (recommended)
 * Copy another payload into `/etc/fusee-launcher/`, change `fusee.bin` in `/etc/fusee-launcher/modchipd.sh` to the new payload's filename, and `systemctl restart fusee-launcher` (or `reboot`).
 
## Building

### Dependencies

Framboise's builder, pi-gen runs on Debian based operating systems. Currently it is only supported on
either Debian Stretch or Ubuntu Xenial and is known to have issues building on
earlier releases of these systems.

To install the required dependencies for pi-gen you should run:

```bash
apt-get install quilt parted realpath qemu-user-static debootstrap zerofree pxz zip \
dosfstools bsdtar libcap2-bin grep rsync xz-utils file git
```

The file `depends` contains a list of tools needed.  The format of this
package is `<tool>[:<debian-package>]`.


### Config

Upon execution, `build.sh` will source the file `config` in the current
working directory.  This bash shell fragment is intended to set needed
environment variables.

Framboise comes with a default config file. If it doesn't work for you, try configuring more things below.

The following environment variables are supported:

 * `IMG_NAME` **required** (Default: unset)

   The name of the image to build with the current stage directories.  Setting
   `IMG_NAME=Raspbian` is logical for an unmodified RPi-Distro/pi-gen build,
   but you should use something else for a customized version.  Export files
   in stages may add suffixes to `IMG_NAME`.

 * `APT_PROXY` (Default: unset)

   If you require the use of an apt proxy, set it here.  This proxy setting
   will not be included in the image, making it safe to use an `apt-cacher` or
   similar package for development.

   If you have Docker installed, you can set up a local apt caching proxy to
   like speed up subsequent builds like this:

       docker-compose up -d
       echo 'APT_PROXY=http://172.17.0.1:3142' >> config

 * `BASE_DIR`  (Default: location of `build.sh`)

   **CAUTION**: Currently, changing this value will probably break build.sh

   Top-level directory for `pi-gen`.  Contains stage directories, build
   scripts, and by default both work and deployment directories.

 * `WORK_DIR`  (Default: `"$BASE_DIR/work"`)

   Directory in which `pi-gen` builds the target system.  This value can be
   changed if you have a suitably large, fast storage location for stages to
   be built and cached.  Note, `WORK_DIR` stores a complete copy of the target
   system for each build stage, amounting to tens of gigabytes in the case of
   Raspbian.
   
   **CAUTION**: If your working directory is on an NTFS partition you probably won't be able to build. Make sure this is a proper Linux filesystem.

 * `DEPLOY_DIR`  (Default: `"$BASE_DIR/deploy"`)

   Output directory for target system images and NOOBS bundles.

 * `USE_QEMU` (Default: `"0"`)

   Setting to '1' enables the QEMU mode - creating an image that can be mounted via QEMU for an emulated
   environment. These images include "-qemu" in the image file name.

### More info about building

For more information about building, check out the [pi-gen](https://github.com/RPi-Distro/pi-gen) repository.
