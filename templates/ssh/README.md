## Quick guide for OpenSSH

#### OpenSSH cmds list

```bash
# from man --apropos "ssh"
-  ssh                   - OpenSSH remote login client
-  ssh-add               - adds private key identities to the OpenSSH authentication agent
-  ssh-agent             - OpenSSH authentication agent
-  ssh-copy-id           - use locally available keys to authorise logins on a remote machine
-  ssh-keygen            - OpenSSH authentication key utility
-  ssh-keyscan           - gather SSH public keys from servers
-  ssh-keysign           - OpenSSH helper for host-based authentication
-  ssh-pkcs11-helper     - OpenSSH helper for PKCS#11 support
-  ssh-sk-helper         - OpenSSH helper for FIDO authenticator support
*  ssh_config            - OpenSSH client configuration file
-  sshd                  - OpenSSH daemon
-  sshd_config           - OpenSSH daemon configuration file
```

---

#### Configuration file locations

1. `/etc/ssh/ssh_config`: Default configuration for all user
2. `~/.ssh/confg`: User's own configuration file, it takes precedence over the first one if this exist

---

#### Frequently used steps for ssh cmds

0. Do not forget to `chmod` your .ssh folder with
```bash
$ chmod 700 ~/.ssh
```

1. To generate new key
```bash
$ ssh-keygen -t ed25519 -C "your_email@example.com"

# then you should limit permission to private key as 400
$ chmod 400 ~/.ssh/id_ed25519
```

2. Add SSH key to `ssh-agent`
```bash
# 1. Start the ssh-agent in the background
$ eval "$(ssh-agent -s)"
> Agent pid 59566

# 2. Add your generated SSH private key to `ssh-agent`
$ ssh-add ~/.ssh/id_ed25519

# 3. To view the key in `ssh-agent`
$ ssh-add -L
```

3. To testing the SSH connection
```bash
$ ssh -T git@github.com
```

4. You can add keys to `ssh_config`

5. For ssh remote-access
```bash
$ ssh username@somehost.com

# Verbose mode
$ ssh -v username@somehost.com

# Enables forwarding agent
$ ssh -A username@somehost.com
```

---

#### References

- [Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
    - [Generating a new SSH key and adding it to the ssh-agent](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
    - [Using SSH agent forwarding](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding)
- About ssh config files (recommend to use this for alias to ssh)
    - [create-ssh-config-file-on-linux-unix](https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix/)
    - [using-the-ssh-config-file](https://linuxize.com/post/using-the-ssh-config-file/https://linuxize.com/post/using-the-ssh-config-file/)
- Incase of security
    - [Linux login history](https://linuxhandbook.com/linux-login-history/)
