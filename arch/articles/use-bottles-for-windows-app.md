#### Installation

1. Install flatpak first (It's an (almost)official appstore for Linux)

```sh
$ flatpak install bottles
```

2. Install steam to get GL Supported
```sh
$ flatpak install flathub com.valvesoftware.Steam
```

2. Install bottles with flatpak

```sh
$ flatpak run com.usebottles.bottles

# don't forget to 
# 1. install all runners and DLL component for compatability
# 2. Disable Advanced Display Settings > Windows Manager decorations (bug with picom)
# 3. Soda, Caffe seems to work fine (https://docs.usebottles.com/components/runners)
# 4. Disable DXVK and VKD3D on NVIDIA Graphics
```
k
3. Also install flatseal for permissions management

```sh
$ flatpak run com.github.tchx84.Flatseal
```

#### NOTE

1. When installing program just click on .exe installer
If you browse on bottles file open, .exe seems to hidden in some apps
(I guess it mights because of Linux File Permission)

2. You can config font dpi on [Legacy Wine Tools > Configuration](https://askubuntu.com/questions/1313791/how-to-increase-font-size-globally-for-programs-running-on-wine-in-ubuntu-20-10)

---

#### TODO

1. Disable picom on wine running apps

---

#### References

- [Arch - Bottles](https://wiki.archlinux.org/title/Bottles)
- [Bottles Official Installation](https://docs.usebottles.com/getting-started/installation)
- [Flathub of bottles](https://flathub.org/apps/com.usebottles.bottles)
- [Flathub of flatseal](https://flathub.org/apps/com.github.tchx84.Flatseal)
- [For Vulkan GL (AMD)](https://wiki.archlinux.org/title/Vulkan)
- [line download link](https://software.thaiware.com/download.php?id=9498)
- [Where do bottles app file location located?](https://www.reddit.com/r/linux_gaming/comments/xanzzv/comment/inuk2jl/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
