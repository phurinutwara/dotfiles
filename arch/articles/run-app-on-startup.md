#### Command

```sh
$ systemctl --user enable docker-desktop.service
$ systemctl --user enable dropbox.service

# To list all unit files
$ systemctl --user list-unit-files

# NOTE: Flag Description (From `LESS="-p --user" command man systemctl`)
# --user
#     Talk to the service manager of the calling user, rather than
#     the service manager of the system.
#
# WARNING: Don't use sudo, it'll make unit undiscoverable
```
