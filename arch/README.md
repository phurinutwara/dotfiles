#### My personal **Arch Linux** installation guide (2024) -- Draft

##### Goal of this README note

1. **Make myself read later**:\
   I'm trying to backup my knowledge of how each installation step happened\
   because I'm surely know that I will have to install arch in
   serveral times and serveral places\
   So I want to reduce my time later by following my own guide

2. **Stick with Installation from Official Documents but with Easy to Understand Examples**:\
   At first time, I followed all other guides (lists in references section) and ended-up\
   stuck while installing so I have to abort in the middle of installation and re-install
   from start serveral times.

   So I will try to stick with Official installation doc from archlinux as much as possible,\
   it's the best place to references all the time and no outdated

   (** I encourage you to once failed on installation by following other guide first,
   so you will curious why those community guides doesn't work anymore and it will make you deeply understand of installation process of
   linux from end-to-end.)

   (** But if you passed it all, 
   I suggest to take a look on each command.\
   search what's each packages actually does because that's the true reason why we joined using Arch Linux)

3. **Will be my personal Journey of using Linux**:\
   Arch Linux is my first Linux distro I primarily switched.\
   My previous main OS was Windows and macOS.

   I use macOS from my work company but I use Windows with (WSL) for my personal PC
   I found that both WSL and mbp is very slow when using Neovim due to the pc specs (both are old models of intel i5)

   Once I done installing Arch Linux, I loved it definitely.\
   It's very fast when using command-line utility\
   It's Desktop Environment is very customizable\
   I'm getting to know a lot more how linux admin cli utilities is used continuously

   Lastly, it feels like I found truly peace and calm when I'm coding which I never had on Windows and macOS\
   (It might because I get frustated by slow execute on cli app and non-important notifications)

---

##### Target Specification on each component

Current stable (Mr.Silentz config):
```
- Display Server:         **Xorg(x11)** (due to compatability)       # $XDG_SESSION_TYPE to specify
- Display Manger:         Ly
- Desktop Environment:    xfce
- Window Manager:         xfwm4
- Panel:                  xfce4-panel
- Desktop Manager:        xfdesktop
- File Manager:           thunar
- Volume Manager:         thunar-volman
- Audio:                  pulseaudio (works with my GSX1000)
```

Goal to switch:
```
- Display Server:         **Xorg(x11)** (due to compatability)       # $XDG_SESSION_TYPE to specify
- Display Manager:        Ly
- Desktop Environment:    xfce (Still experimenting)
- Window Manager:         i3 (tiled) + keymap hint
- Panel:                  ?? (Still experimenting) 
- Desktop Manager:        ?? (Still experimenting) 
- File Manager:           thunar
- Volume Manager:         thunar-volman
- Audio:                  pulseaudio (works with my GSX1000)
```

---

##### Pre-requisites

1. USB Flash drive (> 2GB)
2. Arch-Linux Image ISO [Download Page](https://archlinux.org/download/)
3. **TIME** x10
4. - **Wired lan cable** 
     - to install pkgs (My wireless receivers are hard to install during installation)
   - **Wi-fi** 
     - (If you go on laptop this will be fine but I won't mention in the guide right now)
5. Wired I/O (bluetooth might gonna run into problems)
6. Nice to have Skills
   - Basic CLI/TUI usage:
     - you will have to run a lot of commands through installation\
       without helping of GUI (if you want deeply understand each command I suggest use `man`)
   - A lot of Googling Research:
     - you usually might ran into problem while installing and you need\
       to be able to fix that stuck point on your own
   - Prepared your mobile phone / tablet while installing:
     - YES, once you ran into problem and you cannot booted back to your OS\
       You should googling it instantly with your side-handed mobile devices
   - Used to install any OS once:
     - You should know how to boot to Installation medium (USB-stick)\
       by knowing how to open **boot menu** in your bios,\
       turning off fast secure boot, etc.

---

0. Burn Arch Linux Image ISO to USB-stick with Etcher (it's ease of use software)

1. ... make the way until boot to arch linux installer medium... (i'll update this later with pic example)

2. Synchronize pacman packages

   1. Make sure you have internet connection by trying `ping archlinux.org`\
      because if you doesn't has internet connection you won't able to install any\
      required package and once you alter your disk by `cfdisk`\
      you won't be able to boot to your OS back if you only have one OS installed on your PC
   2. Use pacman to sync all packages to medium \
      (you will get newest release cli-app due to rolling updates)
      ```sh
      $ pacman -Syy                            

      # Explanation of flags (try `man pacman` for detail)

      # -S, --sync is Synchronize packages. 
      # Packages are installed directly from the remote
      # repositories, including all dependencies required to run the packages.
      # NOTE: AKA yarn add [...]

      # -y, --refresh
      # Download a fresh copy of the master package databases (repo.db) from the
      # server(s) defined in pacman.conf(5). This should typically be used each time you
      # use --sysupgrade or -u. Passing two --refresh or -y flags will force a refresh of
      # all package databases, even if they appear to be up-to-date.

      ```

3. Disk Partitioning (take longest time to understand)


   1. `lsblk` to view summary of disk and partitions\
   (**NOTE: do this everytimes to prevent unintended
      format on wrong disk)

   2. It needs 3 partitions for arch linux according to [Arch Documentation](https://wiki.archlinux.org/title/Installation_guide#Example_layouts)
      1. EFI System Partition at /boot (**1 GB**)
      2. Root Partition (> 32 GB) [Type: Linux system]
      3. Linux Swap (> 4 GB base on your ram) [It will need when hibernation]

   3. `fdisk -l | less` to view list with details of disk and partitions

   4. But I recommend use `cfdisk /dev/nvme1n_p_` to manipulate changes of partition for ease of use
      - do noted that if you can not found the free space on cfdisk\
        you might use `cfdisk /dev/nvme1n1` rather than `cfdisk /dev/nvme1n1p5`\
        (this means you want to `cfdisk` all spaces in the disk not just partitioned one)
   
   5. After done partition let's **format the partitions**
   ```sh
   $ lsblk                                 # to review your summary ls block

   # For me,
   # NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
   # sda           8:0    1  28.7G  0 disk <-- This is your installation medium
   # ├─sda1        8:1    1   950M  0 part     Just leave it alone
   # └─sda2        8:2    1   164M  0 part
   # nvme1n1     259:0    0 931.5G  0 disk
   # ├─nvme1n1p1 259:1    0    16M  0 part
   # ├─nvme1n1p2 259:2    0 578.3G  0 part
   # ├─nvme1n1p3 259:3    0     1G  0 part <-- I will use this as EFI System Partition (/boot/efi)
   # ├─nvme1n1p4 259:4    0     8G  0 part <-- I will use this as Linux Swap Partition
   # └─nvme1n1p5 259:5    0 344.2G  0 part <-- I will use this as Linux System Partition (/) (root folder)

   # EFI Stuffs
   $ mkfs.fat -F 32 /dev/nvme1n1p3         # use your EFI System Partition

   # Linux swap stuffs
   $ mkswap /dev/nvme1n1p4                 # use your Linux swap partition
   $ swapon /dev/nvme1n1p4                 # use your Linux swap partition

   # Linux root stuffs
   $ mkfs.ext4 /dev/nvme1n1p5              # use your Linux system partition (for /root)
   ```

4. Mounting time
```sh
$ mount /dev/nvme1n1p5 /mnt                # mount your root drive

$ mkdir /mnt/boot/efi                      # create efi boot partition for Linux EFI Partition in your root drive
$ mount /dev/nvme1n1p3 /mnt/boot/efi       # mount your EFI partition
```

5. Prepare base/essential packages by `pacstrap`
```sh
$ pacstrap -K /mnt base linux linux-firmware sudo vim zsh

# Explanation of flags (try `man pacstrap` for detail)
# ...
#  TODO: Explains the flags here
#        Mr.Silentz use -i flag
#        Other-else use -K flag
# ...

# Explanation of each packages
# base is                     ... [REQUIRED]
# linux is                    ... [REQUIRED]
# linux-firmware is           ... [REQUIRED]
# sudo is                     ... [REQUIRED]
# vim is                      ... [REQUIRED]
```

6. Generate fstab into your new file system
```sh
$ genfstab -U -p /mnt > /mnt/etc/fstab

# Explanation of flags (try `man genfstab` for detail)
# TODO: ...explain here...
```

7. arch-chroot (change root) to mounted drive
```sh
$ arch-chroot /mnt
```

8. Setup locale
```sh
$ vim /etc/locale.gen                      # uncomment your using langauge, for me `en_US.UTF-8` and `th_TH.UTF-8`
$ locale-gen                               # this will uses /etc/locale.gen to generate
```

9. Setup system timezone
```sh
echo "LANG=en_US.UTF-8" > /etc/locale.conf
$ ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
```

10. Setup hardware clock
```sh
$ hwclock --systohc
```

11. Setup hostname and `/etc/hosts`
```sh
echo 'phurinutw-pc' > /etc/hostname
$ vim /etc/hosts

# add these 3 lines at the end of the `/etc/hosts` file
127.0.0.1    localhost
::1          localhost
127.0.1.1    phurinutw-pc
```

12. Add new user
```sh
$ useradd -m -G wheel,storage,power,audio,video -s /bin/zsh phurinutw 

# other use /bin/bash, but i personally use /bin/zsh and i had pacstrapped it

# if you added user and group but your typo was wrong,
# later you can use usermod to alter the user. for example,

# $ useradd -m -G wheel -s /bin/besh phurinutw   <- you config default shell wrong and also you want more usergroup
# $ usermod -m -G wheel,storage,power,audio,video -s /bin/zsh phurinutw   <- this will modified all of your params
```

13. Set up your root and your user password
```sh
$ passwd                                   # this will set-up the root password
$ passwd phurinutw                         # this will set-up your user password for login
```

14. Add wheel group to make your user able to use sudo cmds
```sh
EDITOR=vim visudo                          # I use vim so I add EDITOR env
                                           # If you don't, just leave plain with `visudo`

# uncomment this line in visudo file:
# %wheel ALL=(ALL) ALL
```
15. Install and config grub (it's the bootloader)
```sh
$ pacman -S grub efibootmgr os-prober mtools
                                           # `grub` and `efibootmgr` is required but
                                           # added `os-prober` and `mtools`
                                           # only if you are dual booting

$ vim /etc/default/grub                    # Uncomment > GRUB_DISABLE_OS_PROBER=false

$ grub-install /dev/nvme1n1p3              # use your previous mounted EFI System Partition
$ grub-mkconfig -o /boot/grub/grub.cfg     # this will genearate the config
```

16. Install essential network packages, The Network Manager
    : so we can make connection during post-installation
```sh
$ pacman -S dhcpcd networkmanager resolvconf
$ systemctl enable sshd
$ systemctl enable dhcpcd
$ systemctl enable NetworkManager
$ systemctl enable systemd-resolved
$ exit                                     # exit the arch-chroot terminal from mnt drive to medium
```

17. Unmount and reboot
```sh
umount -lR /mnt                            # unmount all the partition recursively
reboot
```
---

##### POST-Installation ( WM/DE Goes here )
1. Installation each components (most fun and customizable part)

   1. Install Nvidia Graphic Driver (Pick just one choice)

      A. [Appropriate Driver](https://linuxiac.com/arch-linux-install/#10-install-a-desktop-environment-on-arch-linux) Open-source driver for ease
      ```sh
      $ pacman -S nvidia nvidia-utils
      ```

      B. [Proprietary Driver]( https://github.com/QuantiniumX/Guide-to-install-Arch-Linux/blob/main/Graphics/Nvidia.md )

   2. Install Desktop Server 

      A. [Xorg](https://github.com/silentz/arch-linux-install-guide?tab=readme-ov-file#configuring-installed-arch-linux) <- My main choice
      ```sh
      $ pacman -S xorg xorg-apps xorg-xinit xdotool xclip
      ```

   3. Arch User Repository helper (I go for [ yay ](https://github.com/Jguer/yay)
   ```sh
   $ pacman -S --needed git base-devel
   $ git clone https://aur.archlinux.org/yay.git
   $ cd yay
   $ makepkg -si
   ```

   4. Desktop Environment (DE/WM)
      A. i3 (My main)
      ```sh
      $ sudo pacman -S i3 dmenu firefox i3status i3lock lxappearance
      $ sudo pacman -S rofi ranger thunar alacritty dunst \
                       xss-lock picom light pango flameshot gsimplecal \
                       thunar-archive-plugin thunar-media-tags-plugin

      $ yay -S picom        # pycom as composite manager (x11 compositor)
      $ yay -S polybar      # polybar for status bar
      $ yay -S feh          # Image viewer (as background)
      $ yay -S rofi         # better of dmenu
      $ yay -S ranger       # cli-styled file explorer
      $ yay -S lxappearance # for customize theme of i3
      $ yay -S light        # for customize display light
      $ yay -S pango        # for text-rendering
      ```
      NOTE: use `xrandr` to adjust desktop resolution size
      ```sh
      # ~/.xprofile to run xrandr when logging in
      # see more: https://askubuntu.com/a/754233
      
      xrandr --output DP-4 --mode 5120x1440 --rate 240
      ```

      B. Xfce (Silentz's stable as a Fallback DE)
      ```sh
      $ sudo pacman -S dbus xfce4 xfce4-screenshooter \
      $   thunar-archive-plugin thunar-media-tags-plugin \
      $   xfce4-xkb-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin \
      $   xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver \
      $   xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin network-manager-applet
      ```

   5. Desktop Manager (For switch between i3 and Xfce)
   ```sh
   $ sudo pacman -S ly
   $ sudo systemctl enable ly
   ```

   6. [Useful packages](https://github.com/silentz/arch-linux-install-guide?tab=readme-ov-file#configuring-installed-arch-linux)
   <!-- TODO: Take a look on each utils -->
   ```sh
   $ sudo pacman -S bind dialog intel-ucode git reflector bash-completion w3m
   $ sudo pacman -S base-devel lshw zip unzip htop xsel tree fuse2 keychain arandr powertop inxi
   $ sudo pacman -S wget iw wpa_supplicant openbsd-netcat axel tcpdump mtr net-tools rsync conntrack-tools ethtool
   $ sudo pacman -S sof-firmware pulseaudio alsa-utils alsa-plugins pavucontrol

   $ sudo pacman -S pipewire               # some one said better than pulseaudio
   $ yay -S openfortigui
   ```

   7. SSD TRIM
   ```sh
   $ sudo systemctl enable fstrim.timer
   ```

   8. Bluetooth
   ```sh
   $ sudo pacman -S bluez bluez-utils blueman
   $ sudo systemctl enable bluetooth
   ```

   9. Improve battery usage
   ```sh
   $ sudo pacman -S tlp tlp-rdw acpi acpi_call
   $ sudo systemctl enable tlp
   $ sudo systemctl mask systemd-rfkill.service
   $ sudo systemctl mask systemd-rfkill.socket
   ```

   10. Fonts (`fc-list` to view installed fonts name)
   ```sh
   $ sudo pacman -S noto-fonts noto-fonts-emoji ttf-ubuntu-font-family ttf-dejavu ttf-freefont
   $ sudo pacman -S ttf-liberation ttf-droid ttf-roboto terminus-font
   $ yay -S ttf-nerd-fonts
   $ yay -S ttf-jetbrains-mono-nerd
   $ yay -S ttf-nerd-fonts-symbols
   $ yay -S ttf-nerd-fonts-symbols-mono
   ```

   11. Theme and Icons
   <!-- TODO: Customize your own -->
   ```sh
   $ sudo pacman -S arc-gtk-theme
   $ sudo pacman -S papirus-icon-theme
   ```

   12. Setup the fastest pacman mirror
   ```sh
   $ sudo reflector --country Thailand,Singapore --fastest 10 --threads `nproc` --save /etc/pacman.d/mirrorlist
   ```

   13. TODO: Intall printing settings

   14. NetworkManager additionals:
   <!-- TODO: Do research -->
   ```sh
   $ sudo pacman -S nm-connection-editor networkmanager-openvpn
   ```

   15. TODO: Keymap binder and language switcher
   See more: https://ejmastnak.com/tutorials/arch/typematic-rate/
   See more: https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration#Systemd_service

   16. TODO: My wifi dongle (TP-Link Archer TX20UH)

   17. Enable hibernation

   ```ssh
   $ sudo lshw
     *-usb:1 UNCLAIMED
          description: Generic USB device
          product: 802.11ac WLAN Adapter
          vendor: Realtek
          physical id: 5
          bus info: usb@1:5
          version: 0.00
          serial: 00e04c000001
          capabilities: usb-2.00
          configuration: maxpower=500mA speed=480Mbit/s

   ```

---

##### References:
1. [Official Arch installation (archlinux.org)](https://wiki.archlinux.org/title/Installation_guide):
   : Hardest but always up-to-dated, use this as reference when other guide failed due to out-dated
2. [Easy-follow but outdated installation](https://linuxiac.com/arch-linux-install/)
   : This is the first place I follow but I stuck when mount the device
   : (I did not create swap partition and somehow `mount` does not work)
3. [QuantiniumX/Guide-to-install-Arch-Linux](https://github.com/QuantiniumX/Guide-to-install-Arch-Linux)
   : Nicely explains but bloat on pre-install packages
   : He didn't mention on packages `pacman -S ...` and I stop follow him later on installing
   : because I don't know whether all of those packages will work on my PC or not
4. [silentz/arch-linux-install-guide](https://github.com/silentz/arch-linux-install-guide)
   : His step is very clean and clear and somehow his commands are more reasonable than the official doc
   : I followed him later until I chose to go with Xfce desktop environment, and it's beatiful and stable to use
   : Only downside is, he use `fdisk` while partitioning drives and it's hard to follow
5. [itsfoss](https://itsfoss.com/install-arch-linux/)
   : Somehow I like how this blog using words and examples to explain, it easy to read and follow

My [Post-installation](https://wiki.archlinux.org/title/Installation_guide#Post-installation) places to read

1. [General recommandations from Arch](https://wiki.archlinux.org/title/General_recommendations)
2. [List of applications from Arch](https://wiki.archlinux.org/title/List_of_applications)
3. [itsfoss post-install](https://itsfoss.com/things-to-do-after-installing-arch-linux/)

---

#### TODO:

- Catagorized install processes to group and explain more simpler and clearer
- Add some gif for better explanation
- Try switch to use i3, awesomeWM once expertise at Arch linux
- Move this doc to [docusaurus](https://docusaurus.io/) for powered with MDX

---

#### Current research:

Display Server (Xorg, Wayland)
- https://www.tuxedocomputers.com/en/Whats-the-deal-with-X11-and-Wayland-_1.tuxedo
- https://www.baeldung.com/linux/display-server-xorg-wayland

DM: Display Manager (GDM, SDDM, **Ly**)
- https://www.baeldung.com/linux/display-managers-install-uninstall

DE: Desktop Environment (GNOME, KDE, XFCE)
- https://www.vpsserver.com/gnome-vs-xfce-vs-kde/
- https://www.reddit.com/r/i3wm/comments/9lonc8/what_de_if_any_do_i3users_use/
  : E39M5S62 - I run i3wm on top of XFCE on my laptop (xfdesktop, bar, etc are all disabled).
  : It gets me zero-effort support for suspend/hibernate, volume keys, brightness keys, etc.
  : On my workstation, I just run i3wm via lightdm.

WM: i3wm
- https://www.youtube.com/watch?v=8YE1LlTxfMQ&list=PLsz00TDipIffGKMW4hmzmwXTvARXyJMn8&index=2