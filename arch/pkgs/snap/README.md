# Snap

If you encounter an error like this

```sh
$ sudo snap install datagrip --classic
error: cannot install "datagrip": classic confinement requires snaps under /snap or symlink from
/snap to /var/lib/snapd/snap
```

you have to link an command first

```sh
$ sudo ln -s /var/lib/snapd/snap /snap
```

### See also

- https://snapcraft.io/
- https://wiki.archlinux.org/title/Snap
