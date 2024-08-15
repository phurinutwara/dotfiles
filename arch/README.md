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

##### Specification

```
- Display Server:         Wayland                              # $XDG_SESSION_TYPE to specify
- Display Manager:        -
- Desktop Environment:    Hyprland
- File Manager:           thunar
- Volume Manager:         thunar-volman
- Audio:                  pipewire
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

$ mkdir -p /mnt/boot/efi                      # create efi boot partition for Linux EFI Partition in your root drive
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
$ useradd -m -G wheel,storage,power,audio,video,log,input -s /bin/zsh pwarch

# other use /bin/bash, but i personally use /bin/zsh and i had pacstrapped it

# if you added user and group but your typo was wrong or there wasn't has a specific group yet,
# later you can use usermod to alter the user. for example,

# $ useradd -m -G wheel -s /bin/besh pwarch   
#    ∟ you config default shell wrong and also you want more usergroup

# $ usermod -m -G wheel,storage,power,audio,video -s /bin/zsh pwarch
#    ∟ this will modified all of your params
```

13. Set up your [root](https://wiki.archlinux.org/title/installation_guide#Root_password) and your user password
```sh
$ passwd                                   # this will set-up the root password
$ passwd pwarch                            # this will set-up your user password for login
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
$ pacman -S openssh dhcpcd networkmanager resolvconf # maybe resolvconf = systemd-resolvconf ?
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
   ```sh
   $ sudo pacman -S bind dialog intel-ucode reflector bash-completion
   $ sudo pacman -S base-devel lshw zip unzip htop xsel tree fuse2 keychain arandr powertop inxi
   $ sudo pacman -S wget iw wpa_supplicant openbsd-netcat axel tcpdump mtr net-tools rsync conntrack-tools ethtool
   $ sudo pacman -S sof-firmware alsa-utils alsa-plugins
   $ sudo pacman -S eza neovim firefox ripgrep lazygit bat bat-extras btop gvfs lsof neofetch nmap fzf ghq tldr rust
   $ sudo pacman -S gnome-terminal docker obsidian
   $ sudo pacman -S gparted btrfs-progs    # A Partition Magic clone, frontend to GNU Parted + btrfs tool

   $ sudo pacman -S pavucontrol            # GUI Audio Control panel for pulseaudio, pipewire-pulse

   $ yay -S nvm snapd docker-desktop
   $ sudo pacman -S docker-compose
   $ nvm install --lts

   # flatpak
   $ sudo pacman -S flatpak
   $ flatpak install flathub com.usebottles.bottles
   $ flatpak install flathub com.github.tchx84.Flatseal
   $ flatpak install flathub net.lutris.Lutris        # See https://lutris.net/

   $ yay -S wine wine-mono wine_gecko winetricks
   $ yay -S lib32-gnutls                      # [for https support]

   # initialize snap
   $ systemctl enable --now apparmor
   $ systemctl enable --now snapd.apparmor
   $ systemctl enable --now snapd
   $ sudo ln -s /var/lib/snapd/snap /snap

   # dropbox, See https://wiki.archlinux.org/title/Dropbox
   $ sudo pacman -S fq
   $ yay -S dropbox thunar-dropbox

   # obs, See https://wiki.archlinux.org/title/Open_Broadcaster_Software
   $ sudo pacman -S obs-studio

   # thunar stuffs
   $ sudo pacman -S ark                    # gui file archiver for thunar
   $ sudo pacman -S nsxiv                  # gui image viewer
   $ sudo pacman -S tumbler                # image previewer for thunar

   # pacman cache cleaner
   $ sudo pacman -S pacman-contrib
   ```

   4. Desktop Environment (DE/WM)

      A. Hyprland (See https://wiki.hyprland.org/Getting-Started/Master-Tutorial/)
      ```sh
      $ sudo pacman -S hyprland hypridle hyprlock xdg-desktop-portal-hyprland polkit-kde-agent qt5-wayland qt6-wayland
      $ sudo pacman -S gnome-control-center gtk3 gtk4 nwg-look pango libdbusmenu-gtk3
      $ sudo pacman -S ffmpeg gvfs
      $ sudo pacman -S wl-clipboard copyq thunar thunar-volman thunar-media-tags-plugin thunar-archive-plugin playerctl
      $ sudo pacman -S yq tmux

      # See https://aylur.github.io/ags-docs/config/installation/
      #     https://pipewire-debian.github.io/pipewire-debian/
      #     https://github.com/Aylur/dotfiles/tree/main
      #     https://github.com/hyprland-community/awesome-hyprland
      $ yay -S aylurs-gtk-shell matugen hyprpicker-git # or aylurs-gtk-shell-git, try `ags --init` to link types folder
      $ sudo pacman -S gtk3 fd sass swww gnome-bluetooth-3.0 brightnessctl qt5ct qt6ct
      $ sudo pacman -S pnpm
      $ pnpm setup
      $ pnpm -g add npm nvm bun jest typescript
      $ sudo ln -s $(pnpm root -g)/bun/bin/bun.exe /usr/bin/bun
      $ sudo ln -s $(pnpm root -g)/bun/bin/bun.exe /usr/local/bin/bun

      # See https://wiki.archlinux.org/title/PipeWire#Audio
      #     https://github.com/mikeroyal/PipeWire-Guide#installing-pipewire-on-arch-linux
      #     https://kaeru.my/notes/pipewire-surround-headphones -- jconvolver not work
      #     https://forum.endeavouros.com/t/virtual-surround-sound-in-pipewire/24958 -- how to use filter-chain (see my dotfiles/config/pipewire)
      #     https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Filter-Chain#virtual-surround
      #     https://lemmy.world/post/1865680 -- best describe
      #     https://airtable.com/appayGNkn3nSuXkaz/shruimhjdSakUPg2m/tbloLjoZKWJDnLtTc
      $ sudo pacman -S pipewire wireplumber pipewire-audio pipewire-pulse pipewire-alsa pipewire-jack sox
      $ sudo pacman -S helvum qpwgraph # pipewire GUI tool
      $ systemctl --user enable --now pipewire.socket
      $ systemctl --user enable --now pipewire-pulse.socket
      $ systemctl --user enable --now wireplumber.service

      # Install vulkan, See https://wiki.archlinux.org/title/Vulkan\#Installation
      sudo pacman -S vulkan-icd-loader vulkan-tools

      # illogical-impulse (See https://github.com/end-4/dots-hyprland)
      ## ags
      $ sudo pacman -S --needed git gobject-introspection meson
      $ sudo pacman -S --needed gjs glib2 glib2-devel glibc gtk3 gtk-layer-shell libpulse pam
      $ sudo pacman -S --needed gnome-bluetooth-3.0 greetd libdbusmenu-gtk3 libsoup3 libnotify networkmanager power-profiles-daemon upower
      ## audio
      $ sudo pacman -S --needed pavucontrol wireplumber libdbusmenu-gtk3 playerctl swww
      ## backlight
      $ sudo pacman -S --needed brightnessctl ddcutil
      ## basic
      $ sudo pacman -S --needed axel bc coreutils cliphist cmake curl fuzzel rsync wget ripgrep jq npm meson typescript gjs xdg-user-dirs
      ## bibata-cursor
      $ yay -S --needed bibata-cursor-theme
      ## fonts-themes
      $ yay -S --needed ttf-material-symbols-variable ttf-gabarito adw-gtk3 ttf-readex-pro ttf-rubik-vf
      $ sudo pacman -S --needed qt5ct qt5-wayland fontconfig ttf-jetbrains-mono-nerd ttf-space-mono-nerd fish foot starship
      ## gnome
      $ sudo pacman -S --needed polkit-gnome gnome-keyring gnome-control-center blueberry networkmanager gammastep gnome-bluetooth-3.0
      $ sudo pacman -S --needed fcitx5 fcitx5-configtool xorg-xhost # for running gparted specifically, See https://www.reddit.com/r/hyprland/comments/13ri2nj/gparted_cannot_open_display/ , https://wiki.archlinux.org/title/Xhost
      ## gtk
      $ sudo pacman -S --needed webp-pixbuf-loader gtk-layer-shell gtk3 gtksourceview3 gobject-introspection upower yad ydotool xdg-user-dirs-gtk
      ## microtex
      $ sudo pacman -S --needed tinyxml2 gtkmm3 gtksourceviewmm cairomm
      ## oneui4-icons (TODO)
      ## portal
      $ sudo pacman -S --needed xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
      ## python
      $ sudo pacman -S --needed python-build python-pillow python-pywal python-setuptools-scm python-wheel
      ## python-pymyc
      $ yay -S --needed python-materialyoucolor-git gradience python-libsass python-material-color-utilities
      ## screencapture
      $ sudo pacman -S --needed swappy wf-recorder grim tesseract tesseract-data-eng slurp
      ## widgets
      $ sudo pacman -S --needed hypridle hyprutils hyprlock dart-sass python-pywayland python-psutil wl-clipboard
      $ yay -S --needed hyprpicker anyrun-git wlogout-git
      ```

   5. Desktop Manager (If you prefer, but i use bare tty with auto-Hypr script)
   ```sh
   $ sudo pacman -S sddm
   $ systemctl enable sddm
   ```

   6. SSD TRIM
   ```sh
   $ sudo systemctl enable fstrim.timer
   ```

   7. Bluetooth
   ```sh
   $ sudo pacman -S bluez bluez-utils blueman
   $ sudo systemctl enable bluetooth
   # if airpods went wrong, uncomment ControllerMode on /etc/bluetooth/main.conf
   ```

   8. Improve battery usage (For laptop)
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
   $ sudo reflector --country 'Thailand,Singapore,' --fastest 10 --threads `nproc` --save /etc/pacman.d/mirrorlist
   ```

   12. Enable [Hibernation](https://wiki.archlinux.org/title/Power_management/Suspend_and_hibernate)
   ```sh
   # 1. find the swap partition first
   $ sudo swapon --show

   # 2. put your swap in grub bootloader (view your uuid on `cat /etc/fstab` or `sudo blkid`)
   $ sudo vim /etc/default/grub
   # Find `GRUB_CMDLINE_ LINUX_DEFAULT="..."` then put resume hook on the last e.g.
   # FROM `GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"` to
   GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=7948187b-f119-450d-9511-9d7707c80be2 nvidia-drm.modeset=1 no_console_suspend"

   # 4. Regenerate grub again
   $ sudo grub-mkconfig -o /boot/grub/grub.cfg

   # 5. config the initramfs to add resume hook
   $ sudo vim /etc/mkinitcpio.conf

   # 6. Look for an HOOKS=(base udev ... filesystems ... fsck)
   # adding the `resume` hook but the resume hook must go after the udev hook
   # adding the `systemd` hook before udev
   # See https://www.reddit.com/r/hyprland/comments/1cyb0h7/hibernate_on_nvidia/
   # so for me it's like
   HOOKS=(base systemd udev autodetect microcode modconf kms keyboard keymap consolefont block filesystems resume fsck)

   # 7. Configure NVIDIA Settings, https://download.nvidia.com/XFree86/Linux-x86_64/555.58/README/powermanagement.html
   ```sh
   $ sudo nvim /etc/modprobe.d/nvidia.conf

   # Add these
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

   # Fallback network interface (Optional)
   $ sudo pacman -S iwd                    # CLI :: iwctl
   $ sudo systemctl enable --now iwd
   $ sudo pacman -S impala                 # a TUI tool for iwd
   $ yay -S iwgtk                          # a GUI tool for iwd

   # Use iwd as NetworkManager backend
   # See https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend
   $ sudo vim /etc/NetworkManager/conf.d/wifi_backend.conf
   # paste this to let NetworkManager use iwd as backend
   # [device]
   # wifi.backend=iwd
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
   $ sudo systemctl enable --now docker.service
   ```

   18. Backend Development Tools
   ```sh
   $ sudo pacman -S postgresql-client

   $ sudo pacman -S minikube               # See https://minikube.sigs.k8s.io/docs/drivers/docker/
   $ sudo pacman -S kubectl
   $ minikube config set driver docker
   $ minikube start

   $ sudo pacman -S virtualbox             # See https://wiki.archlinux.org/title/VirtualBox

   $ sudo pacman -S vagrant                # See https://wiki.archlinux.org/title/Vagrant
   $ vagrant plugin install vagrant-vbguest vagrant-share

   $ sudo pacman -S jdk8-openjdk           # See https://wiki.archlinux.org/title/Java#OpenJDK

   $ sudo pacman -S maven                  # See https://wiki.archlinux.org/title/Maven
   $ yay -S aws-cli-v2                     # See https://aur.archlinux.org/packages/aws-cli-v2

   $ sudo pacman -S pwgen                  # cli password generator tool
   ```

   19. Auto-login via greetd and agreety
   ```sh
   # See https://wiki.archlinux.org/title/Greetd#Enabling_autologin

   $ sudo vim /etc/greetd/config.toml
   # Append Type this to /etc/greetd/config.toml

   # [initial_session]
   # command = "sh /home/pwarch/dotfiles/zsh/scripts/auto-Hypr.sh"
   # user = "pwarch"

   # Don't for get to change agreety shell to zsh at default_session (default is sh)
   # command = "agretty --cmd /bin/zsh"
   
   $ sudo systemctl enable greetd
   ```

   20. TODO: Encrypt drive via LUKS
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

#### Previous researches:

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
