## Monitor not turning back on when wakeup

#### ISSUE DESCRIPTION

- [x] When dpms is activated by afk and once we come back, <u>the screen did not turn on properly</u>\
- [x] Possibly fix by after timeout, just hibernate or sleep pc, do not use dpms

---

#### EASIEST SOLUTION

Just disable dpms suspend and off feature and then use system hibernation to save the power instead.
By using xfce-power-manager-setting and these configs
System:
  System sleep mode: Hibernate
  When iinactive for: 30 min
Display:
  Blank after:          10 minutes
  Put to sleep after:   Never
  Switch off after:     Never


---

#### SOLUTION

The only way to bring the display port monitor on with nvidia that i tried so on is to switch tty user back and forth
like this [one](https://askubuntu.com/a/1386663/1863744)

I tried `xset dpms off`, `xrandr --auto`. Unfortunately, neither work.
It only has to change virtual terminal to signaling the monitor back on
so i'm gonna inject the script that does this when dpms on hook

0. Make `chvt` run without password
```sh
$ sudo EDITOR=nvim visudo

# Add this to allow wheel group use chvt without password
%wheel ALL=(ALL) NOPASSWD: /usr/bin/chvt

# Make sure user are in wheel group, Replace YOUR_USERNAME with your actual username.
$ sudo usermod -aG wheel YOUR_USERNAME
```

1. Create the scripts at `/etc/systemd/system/switch-tty.service`

```bash
[Unit]
Description=Switch TTYs to Wake Monitor on Resume
After=suspend.target

[Service]
Type=oneshot
ExecStart=/usr/bin/chvt 3
ExecStartPost=/bin/sleep 1
ExecStartPost=/usr/bin/chvt 2
ExecStartPost=/usr/bin/logger "TTY switch executed"

[Install]
WantedBy=suspend.target
```

3. You can force enable the configuration by

```sh
$ sudo systemctl daemon-reload
$ sudo systemctl enable switch-tty.service
```

---

#### SEE ALSO

- [Systemd](https://wiki.archlinux.org/title/Systemd#Writing_unit_files)

---

GRUB FLAGS ABOUT NVIDIA

Kernel Parameters:
  - **nomodeset**\
    This parameter disables Kernel Mode Setting (KMS), which hands over the mode-setting duties from the 
    kernel to the Xorg server or the NVIDIA driver. It's sometimes used to troubleshoot graphics driver issues but 
    can limit graphical performance.

  - **nvidia-drm.modeset=1**\
    This enables DRM (Direct Rendering Manager) kernel mode setting for the NVIDIA driver,
    which can improve performance and compatibility, especially with newer kernels and NVIDIA drivers.

  - **nvidia-drm.modeset=0**\
    This disables DRM kernel mode setting for the NVIDIA driver, relying on the older methods 
    for mode setting. It might be used in cases where there are compatibility issues with newer 
    kernels or specific hardware setups.

In your case, since you're using NVIDIA proprietary drivers, using nvidia-drm.modeset=1 is generally recommended 
for better compatibility and performance unless you encounter issues that require nomodeset or another setting.
