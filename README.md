# ***NEEDS UPDATING***

# RP4Win (Setup scripts for Windows&trade;)

If you like the project and would like to donate click the button below.

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.com/donate/?business=TL3CDWD9QLBDC&no_recurring=0&item_name=Your+supporting+the+further+development+of+RP4Win&currency_code=USD)

---

# What Does This Do?

RP4Win is a batch script tool used to setup a RetroPie-like environment on Windows Operating Systems.<br/>
You can use EmulationStation as a desktop application, or you can setup a Windows machine to be a dedicated Emulator Machine.

**This tool _DOES NOT_ include ROM or BIOS files, they need to be supplied by the end user. (that would be whoever is actually reading this...)**

All RP4Win files are contained in **`(DRIVE):\RP4Win\`** by default.

If you find a bug, or have a feature request please use the [github issue tracker](https://github.com/ironwolf86/RP4Win/issues).

### Supported Systems Include:

- 3do
- ags
- amiga
- amstradcpc
- apple2
- atari2600
- atari5200
- atari7800
- atari800
- atarijaguar
- atarilynx
- atarist
- bbcmicro
- c64
- coco
- colecovision
- daphne
- dragon32
- dreamcast
- fba
- fds
- gameandwatch
- gamegear
- gb
- gba
- gbc
- gc
- intellivision
- mame
- mastersystem
- mega-cd
- mega32x
- megadrive
- msx
- mvs
- n64
- nds
- neogeo
- nes
- ngp
- ngpc
- pcengine
- ps2
- psp
- psx
- saturn
- scraper.exe
- sega32x
- segacd
- sfc
- sg-1000
- snes
- vectrex
- virtualboy
- wii
- wiiu
- zxspectrum

## Some Systems Require BIOS files

They are listed below along with the location to copy BIOS file too.

| Syntax | Description |
| ----------- | ----------- |
| **System** | **Filepath** |
| Amiga | `C:\RP4Win\RetroArch\system\kick13.rom` **OR** <br/>`C:\RP4Win\RetroArch\system\kick20.rom` **OR** <br/>`C:\RP4Win\RetroArch\system\kick31.rom` |
| Atari800 | `C:\RP4Win\RetroArch\system\ATARIXL.ROM` (BIOS for Atari XL/XE OS) **OR** <br/>`C:\RP4Win\RetroArch\system\ATARIBAS.ROM` (BIOS for the BASIC interpreter) **OR** <br/>`C:\RP4Win\RetroArch\system\ATARIOSA.ROM` (BIOS for Atari 400/800 PAL) **OR** <br/>`C:\RP4Win\RetroArch\system\ATARIOSB.ROM` (BIOS for Atari 400/800 NTSC) **OR** <br/>`C:\RP4Win\RetroArch\system\5200.ROM` (BIOS for the Atari 5200) |
| Atari 7800 | `C:\RP4Win\RetroArch\system\7800 BIOS (U).rom` |
| CoCo | `C:\RP4Win\RetroArch\system\bas13.rom` |
| Dragon32 | `C:\RP4Win\RetroArch\system\d32.rom` |
| Dreamcast | `C:\RP4Win\RetroArch\system\dc_boot.bin` **AND** <br/>`C:\RP4Win\RetroArch\system\dc_flash.bin` |
| FDS | `C:\RP4Win\RetroArch\system\disksys.rom` |
| gba | `C:\RP4Win\RetroArch\system\gba_bios.bin` |
| psx | `C:\RP4Win\RetroArch\system\SCPH1001.BIN` |
| PS2 | `C:\RP4Win\Emulators\PCSX2\bios\ANYPS2BIOS.bin` |
| neo geo | `C:\PATH\TO\ROMS\neogeo\neogeo.zip` |
| sega cd | `C:\RP4Win\RetroArch\system\us_scd1_9210.bin` (or rename to bios_CD_U.bin) **OR** <br/>`C:\RP4Win\RetroArch\system\eu_mcd1_9210.bin` (or rename to bios_CD_E.bin) **OR** <br/>`C:\RP4Win\RetroArch\system\jp_mcd1_9112.bin` (or rename to bios_CD_J.bin) *for Europe and Japan respectively* |
| Sega Saturn | `C:\RP4Win\RetroArch\system\saturn_bios.bin` |

---

# The List Of Features Is As Follows:

# Automated Installers

There are 3 options for automated installation.

### **1. Default Installer**

This option handles the ROM directories for you.<br/>
It creates a system folder for most supported ROMS.<br/>
Once installation completes the ROMS folder is opened and you can transfer ROMs into the system folders.<br/>
This option is great for people who do not have gigantic (1TB+) collections and can easily fit their ROMs on the installation drive.

---

### **2. Custom Installer**

This option is to setup ROM directories like option 1, but in a place of your choosing.<br/>
You will be prompted to enter the main folder you'd like to use for roms.

Syntax: `E:\ROMS`, `D:\Games`, `F:\Retro`, etc.<br/>
No trailing \\ after the rom path!!

All system subdirectories will be added to the folder specified.<br/>
Example:<br/>
If `E:\ROMS` is specified the following folders will be created:

```
E:\ROMS\3do
E:\ROMS\ags
E:\ROMS\amiga
E:\ROMS\amstradcpc
E:\ROMS\apple2
E:\ROMS\atari2600
E:\ROMS\atari5200
E:\ROMS\atari7800
E:\ROMS\atari800
E:\ROMS\atarijaguar
E:\ROMS\atarilynx
E:\ROMS\atarist
E:\ROMS\bbcmicro
E:\ROMS\c64
E:\ROMS\coco
E:\ROMS\colecovision
E:\ROMS\daphne
E:\ROMS\dragon32
E:\ROMS\dreamcast
E:\ROMS\fba
E:\ROMS\fds
E:\ROMS\gameandwatch
E:\ROMS\gamegear
E:\ROMS\gb
E:\ROMS\gba
E:\ROMS\gbc
E:\ROMS\gc
E:\ROMS\intellivision
E:\ROMS\mame
E:\ROMS\mastersystem
E:\ROMS\mega32x
E:\ROMS\mega-cd
E:\ROMS\megadrive
E:\ROMS\msx
E:\ROMS\mvs
E:\ROMS\n64
E:\ROMS\nds
E:\ROMS\neogeo
E:\ROMS\nes
E:\ROMS\ngp
E:\ROMS\ngpc
E:\ROMS\pcengine
E:\ROMS\ps2
E:\ROMS\psp
E:\ROMS\psx
E:\ROMS\saturn
E:\ROMS\sega32x
E:\ROMS\segacd
E:\ROMS\sfc
E:\ROMS\sg-1000
E:\ROMS\snes
E:\ROMS\vectrex
E:\ROMS\virtualboy
E:\ROMS\wii
E:\ROMS\zxspectrum
```

And a system config file for EmulationStation will be generated to make adding ROMS drag and drop

---

### **3. No ROM Dirs**

This option is if you **do not** wish to use the default ROM directories (`(DRIVE):\RP4Win\EmualationStation\.emulationstation\roms`)<br/>
Once the setup is completed you will need to edit the **es_systems.cfg** file to change the ROM directories to your liking.<br/>
This option is great for people who have ROMS on another drive (like me), or just do not wish to use the default folder.

---

**Once the automated installer is done simply double click the EmulationStation icon on your desktop**

# Manage EmulationStation

### **Update/Install EmulationStation**

This is for updating EmulationStation.<br/>
It also backs up your current EmulationStation to `(DRIVE):\RP4Win\Backups` with a timestamped .zip file.<br/>
The backup is in case something breaks with a newer build when updating.

### **Manage es_systems.cfg**

This is for generating and editing es_systems.cfg

### **Manage EmulationStation Themes**

This tool has several features, and will setup GIT to `(DRIVE):\RP4Win\Tools\Git` 

#### **Install/Update All Themes**

Relatively Self explanatory. This installs every available theme for EmulationStation.
		
#### **Install/Update Individual Themes**

This option lets you select the theme you want by name and install 1 by one. <br/>
Useful if you don't wish to install 80 themes and just want a specific one.
		
#### **Theme Gallery/Previews**

This downloads previews for all available themes and writes them to a HTML file.<br/>
The HTML file is them launched with your default browser.<br/>
Hover over the image to see which theme it belongs to.<br/>
This is to help with the Individual theme downloader so you can see what you're getting.
		
# Manage RetroArch

### **Install RetroArch 1.6.7**

This installs the latest Stable Build of RetroArch. In case you wanted to revert from a nightly build.

### **Update RetroArch to the Latest Nightly Build**

Updates RetroArch, self explanatory.

### **Generate Clean RetroArch.cfg**

This generates a RetroArch.cfg with nearly default settings<br/>
Changes made are as follows:

- All Games Start in Fullscreen.
- You can bring up the RetroArch menu with Start and Select
	
### **Update RetroArch Cores to the Latest Nightly Build**

Self Explanatory<br/>
This updates all RetroArch Cores (108 total)

# Manage Additional Emulators

This option installs emulators for systems that RetroArch cannot emulate.<br/>
Current emulators are:

- AppleWin
- Hatari
- BeebEm
- XRoar
- Daphne
- jzIntv
- PCSX2

# Manage ROM Directories

This creates the default ROM directories in `(DRIVE):\RP4Win\ROMS`<br/>
You can also create custom ROM directories like `E:\ROMS`<br/>
You can also Share the ROM Directories from here if using a dedicated Emulator Box.

# Manage Dedicated EmuBox Settings

### **Setup All Dedicated Emubox Settings**

This option will do a full setup and turn your RP4Win Installation into a Dedicate Emu Box.<br/>
This option includes installation of all of the options below.<br/>
The only user requires input is during the Auto Login setup.<br/>
This is due to how Windows handles Auto login.

### **RP4Win Auto Start Options**  

From here you can select if you'd like to automatically start RP4Win (EmulationStation) upon login.<br/>
This goes hand in hand with Auto Login.<br/>
You can also remove the Auto Start settings if you no longer with to have Auto Start.

### **Setup Auto Login**

Self Explanatory.<br/>
Opens the netplwiz menu.<br/>
Guides you through setting up Auto Login.

### **Setup RP4Win Folder Shares** 

#### **Setup RP4Win Shares With Default Rom Directory**
 
Sets up the following shares:

- ROMS
- BIOS
- EMULATORS
- EmulationStation
    
The ROMS folder uses the default `(DRIVE):\RP4Win\ROMS`

#### **Setup RP4Win Shares With Custom Rom Directory**

Sets up the following shares

- ROMS
- BIOS
- EMULATORS
- EmulationStation

You will be asked to enter the ROMS directory.<br/>
This option is if you installed using a custom ROMS directory.

#### **Remove RP4Win Shares**

Self Explanatory.<br/>
Removes all shares created by this script.

### **Setup System Name**

From here you can set your PC's hostname to the default RP4Win, or to any custom hostname you'd like.<br/>
This is to make it easier to access the shares on the computer.


# System Cleanup

This option is for cleaning up parts of RP4Win or removing RP4Win entirely.<br/>
Mostly used by me for Testing, but if anyone needs to clean up and remove files this is for you.
