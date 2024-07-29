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
- Display Server:         Wayland (due to compatability)       # $XDG_SESSION_TYPE to specify
- Display Manager:        Sddm
- Desktop Environment:    Hyprland
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
       without helping of GUI (if you want deeply understand each command I suggest use [`man`](https://wiki.archlinux.org/title/man_page))
     - I use $ before command to demonstrate a command to run in shell prompt\
       otherwise, just a description in a code-block
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
   - [Best Reddit for newb ever](https://www.reddit.com/r/archlinux/comments/u5by1d/how_does_a_noob_read_the_arch_wiki/) !

---

0. Burn Arch Linux Image ISO to USB-stick with Etcher (it's ease of use software)

1. ... make the way until boot to arch linux installer medium... (i'll update this later with pic example)
   : NOTE: I just saw there are easy [GUIDED INTERACTIVE INSTALLATION](https://youtu.be/8YE1LlTxfMQ?si=bWozdqmq2g_jG1q-&t=280) by using
   : arch install script so I'll give a try later
     ```sh
     root@archiso ~ $ archinstall
     ```

2. Synchronize pacman packages

   1. Make sure you have [internet connection](https://wiki.archlinux.org/title/installation_guide#Connect_to_the_internet) by trying `ping archlinux.org`\
      because if you doesn't has internet connection you won't able to install any\
      required package and once you alter your disk by `cfdisk`\
      you won't be able to boot to your OS back if you only have one OS installed on your PC

   2. Use pacman to sync all packages to medium \
      (So you will get newest release of cli utility apps when `pacman -S` later in this guide)
      ```sh
      $ pacman -Syy

      # Explanation of flags (try `man pacman` for detail)

      # -S, --sync is Synchronize packages. 
      # Packages are installed directly from the remote
      # repositories, including all dependencies required to run the packages.

      # -y, --refresh
      # Download a fresh copy of the master package databases (repo.db) from the
      # server(s) defined in pacman.conf(5). This should typically be used each time you
      # use --sysupgrade or -u. Passing two --refresh or -y flags will force a refresh of
      # all package databases, even if they appear to be up-to-date.

      # NOTE: This performs like `brew update`
      ```

3. Disk Partitioning (take longest time to understand)

   1. `lsblk` to view summary of disk and partitions\
   (**NOTE: do this everytimes to prevent unintended
      format on wrong disk)

   2. It needs 3 partitions for arch linux according to [Arch Documentation](https://wiki.archlinux.org/title/Installation_guide#Example_layouts)
      1. EFI System Partition at /boot (**1 GB**)
      2. Linux Swap (**[Recommend swap space](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/managing_storage_devices/getting-started-with-swap_managing-storage-devices#recommended-system-swap-space_getting-started-with-swap)**) [It will need when hibernation] (See also: [discussion](https://askubuntu.com/questions/49109/i-have-16gb-ram-do-i-need-32gb-swap))
      3. Root Partition (**> 32 GB**) [Type: Linux system]

   3. [`fdisk -l | less`](https://wiki.archlinux.org/title/installation_guide#Partition_the_disks) to view list with details of disk and partitions

   4. But I recommend use `cfdisk /dev/nvme1n_p_` to manipulate changes of partition for ease of use
      - noted that if you can not found the free space on cfdisk\
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
   # ├─nvme1n1p4 259:4    0    24G  0 part <-- I will use this as Linux Swap Partition
   # └─nvme1n1p5 259:5    0 328.2G  0 part <-- I will use this as Linux System Partition (/) (root folder)

   # EFI Stuffs
   $ mkfs.fat -F 32 /dev/nvme1n1p3         # use your EFI System Partition

   # Linux swap stuffs
   $ mkswap /dev/nvme1n1p4                 # use your Linux swap partition
   $ swapon /dev/nvme1n1p4                 # use your Linux swap partition

   # Linux root stuffs
   $ mkfs.btrfs /dev/nvme1n1p5             # use your Linux system partition (for /root) (lately i use btrfs)
   # $ mkfs.ext4 /dev/nvme1n1p5              # use your Linux system partition (for /root)
   ```

4. [Mounting](https://wiki.archlinux.org/title/installation_guide#Mount_the_file_systems) those drives
```sh
$ mount /dev/nvme1n1p5 /mnt                # mount your root drive

$ mkdir /mnt/boot/efi                      # create efi boot partition for Linux EFI Partition in your root drive
$ mount /dev/nvme1n1p3 /mnt/boot/efi       # mount your EFI partition
```

5. Prepare [base/essential packages](https://wiki.archlinux.org/title/installation_guide#Install_essential_packages) by [`pacstrap`](https://man.archlinux.org/man/pacstrap.8)
```sh
$ pacstrap -K /mnt base linux linux-firmware sudo vim zsh

# Explanation of flags (try `man pacstrap` for detail)
# Mr.Silentz use -i flag to Prompt for package confirmation when needed (run interactively).
# Other-else use -K flag to Initialize an empty pacman keyring in the target (implies -G).
# ...

# Explanation of each packages 
# (take a look here, https://archlinux.org/packages/?name=base)
# [REQUIRED] base is Minimal package set to define a basic Arch Linux installation
# [REQUIRED] linux is The Linux kernel and modules 
# [REQUIRED] linux-firmware is Firmware files for Linux 
# [REQUIRED] sudo is Give certain users the ability to run some commands as root 
```

6. Generate [fstab](https://wiki.archlinux.org/title/installation_guide#Fstab) into your new file system
```sh
$ genfstab -U -p /mnt > /mnt/etc/fstab

# Explanation of flags (try `man genfstab` for detail)
# TODO: ...explain here...
```

7. arch-chroot ([change root](https://wiki.archlinux.org/title/Change_root)) to mounted drive
```sh
$ arch-chroot /mnt
```

8. [Setup locale](https://wiki.archlinux.org/title/installation_guide#Localization)
```sh
$ vim /etc/locale.gen                      # uncomment your using langauge, for me `en_US.UTF-8` and `th_TH.UTF-8`
$ locale-gen                               # this will uses /etc/locale.gen to generate
```

9. [Setup system timezone](https://wiki.archlinux.org/title/installation_guide#Time)
```sh
echo "LANG=en_US.UTF-8" > /etc/locale.conf
$ ln -sf /usr/share/zoneinfo/Asia/Bangkok /etc/localtime
$ locale-gen
```

10. Setup hardware clock (Run [`hwclock`](https://man.archlinux.org/man/hwclock.8) to generate `/etc/adjtime`)
```sh
$ hwclock --systohc
```

11. [Setup hostname](https://wiki.archlinux.org/title/installation_guide#Network_configuration) and `/etc/hosts`
```sh
$ echo 'pwarch-pc' > /etc/hostname
$ vim /etc/hosts

# add these 3 lines at the end of the `/etc/hosts` file
127.0.0.1    localhost
::1          localhost
127.0.1.1    pwarch-pc
```

12. [Add new user](https://wiki.archlinux.org/title/Users_and_groups#Example_adding_a_user)
```sh
$ useradd -m -G wheel,storage,power,audio,video -s /bin/zsh pwarch

# other use /bin/bash, but i personally use /bin/zsh and i had pacstrapped it

# if you added user and group but your typo was wrong,
# later you can use usermod to alter the user. for example,

# $ useradd -m -G wheel -s /bin/besh pwarch   
#    ∟ you config default shell wrong and also you want more usergroup

# $ usermod -m -G wheel,storage,power,audio,video -s /bin/zsh phurinutw
#    ∟ this will modified all of your params
```

13. Set up your [root](https://wiki.archlinux.org/title/installation_guide#Root_password) and your user password
```sh
$ passwd                                   # this will set-up the root password
$ passwd phurinutw                         # this will set-up your user password for login
```

14. Add [wheel group](https://wiki.archlinux.org/title/Users_and_groups#Group_list) to make your user able to use sudo cmds
```sh
EDITOR=vim visudo                          # I use vim so I add EDITOR env
                                           # If you don't, just leave plain with `visudo`

# uncomment this line in visudo file:
# %wheel ALL=(ALL) ALL
```
15. Install and config [grub](https://wiki.archlinux.org/title/GRUB) (it's the [bootloader](https://wiki.archlinux.org/title/Arch_boot_process#Boot_loader))
```sh
$ pacman -S grub efibootmgr os-prober mtools
                                           # `grub` and `efibootmgr` is required but
                                           # added `os-prober` and `mtools`
                                           # only if you are dual booting

$ vim /etc/default/grub                    # Uncomment > GRUB_DISABLE_OS_PROBER=false

$ grub-install --target=x86_64-efi --bootloader-id=grub_uefi --recheck      # use your previous mounted EFI System Partition
$ grub-mkconfig -o /boot/grub/grub.cfg     # this will genearate the config
```

16. Install essential network packages, The Network Manager
    : so we can make connection during post-installation
    : (We use `systemctl` to control [service management](https://wiki.archlinux.org/title/General_recommendations#Service_management) which is called [systemd](https://wiki.archlinux.org/title/Systemd))
```sh
$ pacman -S openssh dhcpcd networkmanager resolvconf
$ systemctl enable sshd                    # sshd is the OpenSSH server process
$ systemctl enable dhcpcd                  # DHCP Client, https://wiki.archlinux.org/title/dhcpcd
$ systemctl enable NetworkManager          # Detect and config to automatically connect to networks, https://wiki.archlinux.org/title/NetworkManager
$ systemctl enable systemd-resolved        # Provide network name resolution to local apps via a D-Bus interface, https://wiki.archlinux.org/title/Systemd-resolved

$ exit                                     # exit the arch-chroot terminal from mnt drive to medium
```

17. Unmount and reboot
```sh
umount -lR /mnt                            # unmount all the partition recursively
reboot
```
---

##### POST-Installation (WM/DE Goes here)

1. Installation each components (most fun and customizable part)

   1. Install [Nvidia Graphic Driver](https://wiki.archlinux.org/title/Xorg#Driver_installation)

      A. [Appropriate/Proprietary Driver](https://linuxiac.com/arch-linux-install/#10-install-a-desktop-environment-on-arch-linux)
      ```sh
      $ pacman -S nvidia nvidia-utils
      $ pacman -S nvidia-settings          # GUI Graphic Settings for Nvidia

      # enable these will help suspend and hibernate more able to successful
      $ sudo systemctl enable nvidia-hibernate.service 
      $ sudo systemctl enable nvidia-persistenced.service
      $ sudo systemctl enable nvidia-powerd.service
      $ sudo systemctl enable nvidia-resume.service
      $ sudo systemctl enable nvidia-suspend.service
      ```

   2. Arch User Repository helper (I go for [yay](https://github.com/Jguer/yay))
   ```sh
   # base-devel is Basic tools to build Arch Linux packages
   $ pacman -S --needed git base-devel

   $ git clone https://aur.archlinux.org/yay.git
   $ cd yay
   $ makepkg -si
   ```

   3. [Useful packages](https://github.com/silentz/arch-linux-install-guide?tab=readme-ov-file#configuring-installed-arch-linux)
   <!-- TODO: Take a look on each utils and turn it to list.txt file for later use -->
   ```sh
   $ sudo pacman -S bind dialog intel-ucode reflector bash-completion
   $ sudo pacman -S base-devel lshw zip unzip htop xsel tree fuse2 keychain arandr powertop inxi
   $ sudo pacman -S wget iw wpa_supplicant openbsd-netcat axel tcpdump mtr net-tools rsync conntrack-tools ethtool
   $ sudo pacman -S sof-firmware alsa-utils alsa-plugins
   $ sudo pacman -S eza neovim firefox ripgrep lazygit bat bat-extras btop gvfs lsof neofetch nmap fzf ghq tldr rust
   $ sudo pacman -S gnome-terminal docker obsidian
   $ sudo pacman -S gparted btrfs-progs    # A Partition Magic clone, frontend to GNU Parted + btrfs tool

   $ sudo pacman -S pulseaudio             # Audio driver
   $ sudo pacman -S pulseaudio-bluetooth   # Audio driver - bluetooth support (For airpod support: https://gist.github.com/aidos-dev/b49078c1d8c6bb1621e4ac199d18213b )
   $ sudo pacman -S pavucontrol            # GUI Audio Control panel for pulseaudio

   $ yay -S nvm snapd docker-desktop
   $ nvm install --lts

   # flatpak
   $ sudo pacman -S flatpak
   $ flatpak install flathub com.usebottles.bottles
   $ flatpak install flathub com.github.tchx84.Flatseal

   # initialize snap
   $ systemctl enable --now apparmor
   $ systemctl enable --now snapd.apparmor
   $ systemctl enable --now snapd
   $ sudo ln -s /var/lib/snapd/snap /snap

   # dropbox
   $ sudo pacman -S fq
   $ cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
   ```

   4. Desktop Environment (DE/WM)

      A. Hyprland (See https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)
      ```sh
      $ sudo pacman -S hyprland hypridle hyprlock xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland
      $ sudo pacman -S gnome-control-center gtk4 nwg-look pango libdbusmenu-gtk3
      $ sudo pacman -S pipewire wireplumber ffmpeg gvfs
      $ sudo pacman -S wl-clipboard copyq thunar thunar-volman thunar-media-tags-plugin thunar-archive-plugin playerctl

      # See https://aylur.github.io/ags-docs/config/installation/
      # https://github.com/Aylur/dotfiles/tree/main
      # https://github.com/hyprland-community/awesome-hyprland
      $ yay -S aylurs-gtk-shell matugen hyprpicker-git # or aylurs-gtk-shell-git
      $ sudo pacman -S gtk3 fd sass swww gnome-bluetooth-3.0 brightnessctl
      $ npm i -g bun
      $ sudo ln -s /home/pwarch/.nvm/versions/node/v20.16.0/bin/bun /usr/bin/bun

      # See https://wiki.archlinux.org/title/PipeWire#Audio
      $ sudo pacman -S pipewire-{jack,alsa,pulse}
      ```

      B. i3 (My past main)
      ```sh
      # Install Desktop Server: [Xorg](https://github.com/silentz/arch-linux-install-guide?tab=readme-ov-file#configuring-installed-arch-linux)
      $ pacman -S xorg xorg-apps xorg-xinit xdotool xclip 

      $ sudo pacman -S i3 i3lock lxappearance firefox xfce4
      $ sudo pacman -S dunst \
                       xss-lock picom flameshot gsimplecal \
                       thunar-archive-plugin thunar-media-tags-plugin

      # you can install these at one commands but I seperate 
      # to comment description line-by-line
      $ sudo pacman -S picom               # pycom as composite manager (x11 compositor)
      $ sudo pacman -S polybar             # polybar for status bar (use this instead of i3status)
      $ sudo pacman -S feh                 # Image viewer (as background)
      $ sudo pacman -S rofi                # better of dmenu (use this instead of dmenu)
      $ sudo pacman -S alacritty           # default term for i3
      $ sudo pacman -S kitty               # my prefered choice of term emu
      $ sudo pacman -S ranger              # cli-styled file explorer
      $ sudo pacman -S lxappearance        # for customize theme of i3
      $ sudo pacman -S light               # for customize display light
      $ sudo pacman -S pango               # for text-rendering
      $ sudo pacman -S thunar              # GUI file explorer
      $ sudo pacman -S dunst               # A highly configurable and lightweight notification daemon.
      $ sudo pacman -S flameshot           # Great tool for screenshot

      $ yay -S i3-lock-fancy-git           # beautiful lock screen
      ```
      NOTE: use `sudo nvidia-settings` to adjust desktop resolution size and save to `/etc/X11/xorg.conf` file
            Be sure that on `X Server Display Configuration > Advanced... > Force Full Composition Pipeline`
            must set to true
      ```sh
      # or manual config with xrandr
      # ~/.xprofile to run xrandr when logging in
      # see more: https://askubuntu.com/a/754233

      xrandr --output DP-4 --mode 5120x1440 --rate 240
      ```

      C. Xfce (Silentz's stable as a Fallback DE)
      ```sh
      # Install Desktop Server: [Xorg](https://github.com/silentz/arch-linux-install-guide?tab=readme-ov-file#configuring-installed-arch-linux)
      $ pacman -S xorg xorg-apps xorg-xinit xdotool xclip

      $ sudo pacman -S dbus xfce4 xfce4-screenshooter \
      $   thunar-archive-plugin thunar-media-tags-plugin \
      $   xfce4-xkb-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin \
      $   xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver \
      $   xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin network-manager-applet
      ```

   5. Desktop Manager (For switch between i3 and Xfce)
   ```sh
   $ sudo pacman -S sddm
   $ systemctl enable sddm

   # $ sudo pacman -S lightdm lightdm-gtk-greeter
   # $ sudo systemctl enable --now lightdm
   # $ echo '' | sudo tee -a /etc/lightdm/lightdm.conf
   # $ echo '[Seat:*]' | sudo tee -a /etc/lightdm/lightdm.conf
   # $ echo 'greeter-session=lightdm-gtk-greeter' | sudo tee -a /etc/lightdm/lightdm.conf
   # $ echo 'user-session=i3' | sudo tee -a /etc/lightdm/lightdm.conf

   # $ sudo pacman -S ly (I found that it often crash after wakeup  from hibernate (i use nvidia))
   # $ sudo systemctl enable ly
   ```

   6. SSD TRIM
   ```sh
   $ sudo systemctl enable fstrim.timer
   ```

   7. Bluetooth
   ```sh
   $ sudo pacman -S bluez bluez-utils blueman
   $ sudo systemctl enable bluetooth
   ```

   8. Improve battery usage
   ```sh
   $ sudo pacman -S tlp tlp-rdw acpi acpi_call
   $ sudo systemctl enable tlp
   $ sudo systemctl mask systemd-rfkill.service
   $ sudo systemctl mask systemd-rfkill.socket
   ```

   9. Fonts (`fc-list` to view installed fonts name)
   ```sh
   $ sudo pacman -S noto-fonts noto-fonts-emoji ttf-ubuntu-font-family ttf-dejavu ttf-freefont
   $ sudo pacman -S ttf-liberation ttf-droid ttf-roboto terminus-font
   $ yay -S ttf-nerd-fonts
   $ yay -S ttf-jetbrains-mono-nerd
   $ yay -S ttf-nerd-fonts-symbols
   $ yay -S ttf-nerd-fonts-symbols-mono
   ```

   10. Theme and Icons
   ```sh
   $ yay -S nordic-theme
   $ sudo pacman -S papirus-icon-theme
   ```

   11. Setup the fastest pacman mirror
   ```sh
   $ sudo reflector --country Thailand,Singapore --fastest 10 --threads `nproc` --save /etc/pacman.d/mirrorlist
   ```

   12. Enable [Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate)
   ```sh
   # 1. find the swap partition first
   $ sudo swapon --show

   # 2. put your swap in grub bootloader (view your uuid on `cat /etc/fstab` or `sudo blkid`)
   $ sudo vim /etc/default/grub
   # Find `GRUB_CMDLINE_ LINUX_DEFAULT="..."` then put resume hook on the last e.g.
   # also add acpi_osi for nvidia specific configs
   # FROM `GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"` to
   GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=7948187b-f119-450d-9511-9d7707c80be2 acpi_osi=! acpi_osi=\"Windows 2009\" nvidia-drm.modeset=1"

   # 4. Regenerate grub again
   $ sudo grub-mkconfig -o /boot/grub/grub.cfg

   # 5. config the initramfs to add resume hook
   $ sudo vim /etc/mkinitcpio.conf

   # 6. Look for an HOOKS=(base udev ... filesystems ... fsck)
   # adding the `resume` hook but the resume hook must go after the udev hook
   # so for me it's like
   HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)

   # 7. Configure NVIDIA Settings, https://download.nvidia.com/XFree86/Linux-x86_64/555.58/README/powermanagement.html
   ```sh
   $ sudo nvim /etc/modprobe.d/nvidia.conf
   options nvidia NVreg_PreserveVideoMemoryAllocations=1
   options nvidia NVreg_TemporaryFilePath=/var/tmp
   options nvidia NVreg_EnableMSI=1

   options nvidia_drm modeset=1 fbdev=1
   ```

   # 8. Regenerate initramfs
   $ sudo mkinitcpio -p linux

   # 9. Now test your hiberating by
   $ sudo systemctl hibernate

   ```
   NOTE: If you found when you `sudo systemctl sleep` and it immediately wake up take a look [here](https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#Instantaneous_wakeups_from_suspend)
   ```sh
   # you might want dmidecode to view the last wake up source device triggered
   $ sudo pacman -S dmidecode
   $ sudo dmidecode -t system | grep -P '\tWake-up Type\: '

   # for me it's XHC that cause wakeup so
   $ su root                               # login as root
   $ echo XHC > /proc/acpi/wakeup
   $ exit                                  # exit root
   # /proc/acpi/wakeup will be a temporary method after reboot we have to echo it again so

   # to automate this, try systemd-tmpfiles: https://wiki.archlinux.org/title/Systemd#systemd-tmpfiles_-_temporary_files
   $ sudo pacman -S samba
   $ su root
   $ cat /usr/lib/tmpfiles.d/samba.conf    # just to view that samba got permission as 0755
   
   $ vim /etc/tmpfiles.d/disable-usb-wake.conf
   # put this in the file
   #    Path                  Mode UID  GID  Age Argument
   w+   /proc/acpi/wakeup     -    -    -    -   XHC

   $ exit                                  # exit root
   $ sudo systemctl sleep                  # try your config, it should not wake up instantly.
                                           # to wake your pc up, use power button
   ```

   13. NetworkManager additionals (GUI, vpn):
   ```sh
   $ sudo pacman -S nm-connection-editor networkmanager-openvpn
   $ sudo pacman -S openfortivpn           # for forticlient VPN.
                                           # For pppd Versions > 2.5.0,
                                           # you may need to additionally add the `--pppd-accept-remote`
                                           # command line option to openfortivpn.
   ```

   14. [Keyboard configuration](https://wiki.archlinux.org/title/Xorg/Keyboard_configuration)
       : See more: https://ejmastnak.com/tutorials/arch/typematic-rate/
       : See more: https://wiki.archlinux.org/title/Linux_console/Keyboard_configuration#Systemd_service
   ```sh
   # 1. For Xorg keyboard configs at login we will use .xprofile to remember our config
   $ echo "xset r rate 175 70" >> ~/.xprofile

   # 2. Using `sxhkd` to make keyboard layout switchers, https://wiki.archlinux.org/title/Xorg/Keyboard_configuration#Switch_languages_using_Alt_Shift
   $ localectl                                        # to show your current settings
   $ localectl list-x11-keymap-layouts | grep "th"    # to view the list and grep your language (for me "th")

   $ sudo pacman -S sxhkd                             # sxhkd - Simple X hotkey daemon, https://wiki.archlinux.org/title/Sxhkd
   $ mkdir -p ~/.config/sxhkd
   $ echo 'space + alt
      setxkbmap -query | grep -q 'th' && setxkbmap us || setxkbmap th,us
   ' >> ~/.config/sxhkd/sxhkdrc
   # add the sxhkd daemon to i3config file
   $ echo 'exec --no-startup-id sxhkd' >> ~/.config/i3/config
   ```

   15. My wifi dongle (TP-Link Archer TX20UH -- works with rtl8852au-dkms-git)
      ```sh
      $ sudo pacman -S linux-headers bc gcc

      # $ pacman -Qo lspci
      # /usr/bin/lspci is owned by pciutils 3.6.2-2
      # $ pacman -Qo lsusb
      # /usr/bin/lsusb is owned by usbutils 012-2
      # so
      $ sudo pacman -S pciutils usbutils
      $ sudo pacman -S usb_modeswitch
      $ yay -S rtl8852au-dkms-git

      $ sudo dkms status
      $ sudo dkms install -m ...           # if it wasn't install install it
      ```

   16. TODO: Intall printing settings

   17. Docker
   ```sh
   $ sudo usermod -aG docker pwarch
   $ sudo systemcdtl enable --now docker.service
   ```

---

##### References:
0. [Arch Linux Wiki](https://wiki.archlinux.org/)
   : Please make this as your new home, you gonna visit there a lot
1. [Official Arch installation (archlinux.org)](https://wiki.archlinux.org/title/Installation_guide):
   : Hardest but always up-to-dated, use this as reference when other guide failed due to out-dated
2. [Easy-follow but outdated installation](https://linuxiac.com/arch-linux-install/)
   : This is the first place I follow but I stuck when mount the device but `cfdisk` is beginner friendly :)
   : (I did not create swap partition and somehow `mount` does not work)
3. [QuantiniumX/Guide-to-install-Arch-Linux](https://github.com/QuantiniumX/Guide-to-install-Arch-Linux)
   : Nicely explains but bloat on pre-install packages
   : He didn't mention on packages `pacman -S ...` and I stop follow him later on installing
   : because I don't know whether all of those packages will work on my PC or not
4. [silentz/arch-linux-install-guide](https://github.com/silentz/arch-linux-install-guide)
   : His step is very clean and clear and somehow his commands are more reasonable than the official doc
   : I followed him later and I chose to go with Xfce desktop environment, his config is beatiful and stable to use
   : Only one thing to mention is, he use `fdisk` while partitioning drives and that's hard to follow as a linux newb
5. [itsfoss](https://itsfoss.com/install-arch-linux/)
   : Somehow I like how this blog using words and examples to explain, it easy to read and follow

My [Post-installation](https://wiki.archlinux.org/title/Installation_guide#Post-installation) places to read

1. [General recommandations from Arch](https://wiki.archlinux.org/title/General_recommendations)
2. [List of applications from Arch](https://wiki.archlinux.org/title/List_of_applications)
3. [itsfoss post-install](https://itsfoss.com/things-to-do-after-installing-arch-linux/)

---

#### TODO:

- [x] Catagorized install processes to group and explain more simpler and clearer
- [x] Try switch to use Hyprland, ~~i3~~, ~~awesomeWM~~ once expertise at Arch linux

---

#### KNOWN ISSUES:

- [x] When dpms is activated by afk and once we come back, <u>the screen did not turn on properly</u>\
      - **Solution**: Take a look [HERE](articles/monitor-not-turnon-when-wakeup.md)
---

#### Current research:

- [GUI](https://wiki.archlinux.org/title/General_recommendations#Graphical_user_interface)

   - Display Server (**Xorg**, Wayland)

      - https://www.tuxedocomputers.com/en/Whats-the-deal-with-X11-and-Wayland-_1.tuxedo
      - https://www.baeldung.com/linux/display-server-xorg-wayland

   - DM: Display Manager (GDM, SDDM, **Ly**)

      - https://www.baeldung.com/linux/display-managers-install-uninstall

   - DE: Desktop Environment (GNOME, KDE, XFCE)

      - https://www.vpsserver.com/gnome-vs-xfce-vs-kde/
      - https://www.reddit.com/r/i3wm/comments/9lonc8/what_de_if_any_do_i3users_use/
        : E39M5S62 - I run i3wm on top of XFCE on my laptop (xfdesktop, bar, etc are all disabled).
        : It gets me zero-effort support for suspend/hibernate, volume keys, brightness keys, etc.
        : On my workstation, I just run i3wm via lightdm.

   - WM: i3wm
     - https://www.youtube.com/watch?v=8YE1LlTxfMQ&list=PLsz00TDipIffGKMW4hmzmwXTvARXyJMn8&index=2
     - goal: https://www.reddit.com/r/unixporn/comments/puplj7/i3gaps_polybar_my_first_window_manager_setup_took/
