# Setup Scripts
### Add SSH Key
> Tested on Ubuntu 18.04

This script adds an SSH key to the server for the current user.

It prompts the current user for the public SSH key contents.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/add-ssh-key)
```

[Raw Script Contents](https://raw.githubusercontent.com/JacFearsome/bash-scripts/master/setup/add-ssh-key.sh)

### Setup Apt
> Tested on Ubuntu 18.04

This script updates the apt cache, performs upgrades, and removes unneeded packages.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/setup-apt)
```

[Raw Script Contents](https://raw.githubusercontent.com/JacFearsome/bash-scripts/master/setup/setup-apt.sh)

### Create Sudo User
> Tested on Ubuntu 18.04

This script condenses the few lines of bash needed for creating a new sudo user into a single command.

It prompts the current user for the new user's information.

Usage:
```bash
bash <(curl -sSL https://jrussell.sh/create-sudo-user)
```

[Raw Script Contents](https://raw.githubusercontent.com/JacFearsome/bash-scripts/master/setup/create-sudo-user.sh)
