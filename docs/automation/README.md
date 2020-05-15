# Automation Scripts
### Create Sudo User
This script creates a new sudo user via script arguments.

Download:
```bash
wget https://raw.githubusercontent.com/JacFearsome/bash-scripts/master/automation/create-sudo-user-auto.sh
```

Usage:
```bash
sudo bash create-sudo-user-auto.sh -u user -p1 password -p2 password
```
### Initialize Git Project for a Folder
This script initializes and configures a new git project for a folder.

Download:
```bash
wget https://raw.githubusercontent.com/JacFearsome/bash-scripts/master/automation/git-init-auto.sh
```

Usage:
```bash
bash git-init-auto.sh -d /path/to/project -c "Your First Commit Message" -o https://github.com/JacFearsome/bash-scripts.git
```