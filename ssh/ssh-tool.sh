#!/bin/bash
# JRF SSH utility script

# Argument variables
SSH_FOLDER="$1"
MODE="$2"
SEARCH_TERM="$3"
VERBOSE=false
SILENT=false
SUMMARY=false
KEYS_ADDED=0
KEYS_SKIPPED=0
KEYS_ERRORS=0

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Parse flags
for arg in "$@"; do
  case "$arg" in
    -vv|--verbose) VERBOSE=true ;;
    --silent) SILENT=true ;;
    --summary) SUMMARY=true ;;
  esac
done

# Echo helpers
info() { $SILENT || echo -e "${BLUE}$*${NC}"; }
warn() { $SILENT || echo -e "${YELLOW}$*${NC}"; }
error() { echo -e "${RED}$*${NC}"; }
success() { $SILENT || echo -e "${GREEN}$*${NC}"; }

# Helper for verbose output
verbose_echo() {
  if $VERBOSE; then
    echo -e " + $*"
  fi
}

# Show help
if [[ "$1" == "--help" || "$1" == "-h" || "$MODE" == "--help" || "$MODE" == "-h" ]]; then
  echo -e "\n${BLUE}Usage:${NC} $0 [/path/to/ssh/dir, default: ~/.ssh] [options] [arguments]\n"
  echo -e "${BLUE}Options:${NC}"
  echo "  -vv | --verbose     Show detailed command execution"
  echo "  -h  | --help        Print help message"
  echo "  --silent            Suppress non-error outputs"
  echo "  --summary           Print summary after adding keys\n"
  echo -e "${BLUE}Keys:${NC}"
  echo "  -l  | --list        List all SSH keys with metadata"
  echo "  -k  | --keys        Add all private keys in SSH_FOLDER or ~/.ssh"
  echo "  -p  | --prompt      Show prompts when adding private keys, USE ONLY with --keys"
  echo "  -ak | --addkey KEY  Add KEY to authorized_keys (KEY is path or string)"
  echo "  -cv | --convert FILE Convert SSH key format (supports various formats)"
  echo "  -g  | --grep TERM   Search SSH files for TERM\n"
  echo -e "${BLUE}Files:${NC}"
  echo "  -f  | --fix         Fix permissions for SSH_FOLDER or ~/.ssh"
  echo "  -c  | --create      Create SSH_FOLDER or ~/.ssh and fix permissions"
  echo "  -b  | --backup      Backup config, known_hosts and authorized_keys files\n"
  echo -e "${BLUE}Configuration${NC}"
  echo "  -a  | --agent       Start SSH agent if not running; prints PID"
  echo "  -r  | --restart     Restart SSH agent and services"
  echo "  -s  | --service     Shows statuses for SSH services and agents"
  echo "  -e  | --edit        Edit SSH config file"
  echo "  -es | --editsystem  Edit system SSH config file (requires sudo)"
  echo "  -al | --alias       Generate SSH aliases from config"
  exit 0
fi

# Set default SSH_FOLDER
if [[ -z "$SSH_FOLDER" || "$SSH_FOLDER" =~ ^- ]]; then
  SSH_FOLDER="$HOME/.ssh"
  MODE="$1"
  verbose_echo "SSH_FOLDER=$SSH_FOLDER"
  info "!> SSH dir: $SSH_FOLDER"
fi

# Subcommand: List all SSH keys with metadata
if [[ "$MODE" == "--list" || "$MODE" == "-l" ]]; then
  info "!> Listing SSH keys in $SSH_FOLDER:"
  echo "----------------------------------------"
  if [ -d "$SSH_FOLDER" ]; then
    find "$SSH_FOLDER" -type f | sort | while read -r KEY_FILE; do
      [[ "$KEY_FILE" =~ ".DS_Store"|".bash_history" ]] && continue
      CREATED=$(stat -c %y "$KEY_FILE" 2>/dev/null || stat -f "%Sc" "$KEY_FILE" 2>/dev/null)
      MODIFIED=$(stat -c %y "$KEY_FILE" 2>/dev/null || stat -f "%Sm" "$KEY_FILE" 2>/dev/null)
      FILENAME=$(basename "$KEY_FILE")
      FILE_TYPE=""
      if file "$KEY_FILE" | grep -q "private key"; then
        FILE_TYPE="${BLUE}private:${NC}"
      elif [[ "$KEY_FILE" == *.pub ]]; then
        FILE_TYPE="${GREEN}public: ${NC}"
      elif [[ "$KEY_FILE" == *"known_hosts"* ]]; then
        FILE_TYPE="${YELLOW}hosts:  ${NC}"
      elif [[ "$KEY_FILE" == *"config"* ]]; then
        FILE_TYPE="${YELLOW}config: ${NC}"
      elif [[ "$KEY_FILE" == *"authorized_keys"* ]]; then
        FILE_TYPE="${GREEN}auth:   ${NC}"
      else
        FILE_TYPE="other:  "
      fi
      PREVIEW=$(tail -c 133 "$KEY_FILE" | tr -d '\n')
      echo -e "$FILE_TYPE $FILENAME"
      echo "        Created: $CREATED"
      echo "        Modified: $MODIFIED"
      if file "$KEY_FILE" | grep -q "text"; then
        echo "        Preview: $PREVIEW"
      else
        echo "        Preview: [binary file]"
      fi
      echo "----------------------------------------"
    done
  else
    error "!> No $SSH_FOLDER directory found."
  fi
  exit 0
fi

# Subcommand: Search SSH files
if [[ "$MODE" == "--grep" || "$MODE" == "-g" ]]; then
  [[ -z "$SEARCH_TERM" ]] && SEARCH_TERM="${2#*=}"
  if [[ -z "$SEARCH_TERM" ]]; then
    error "!> Error: No search term provided. Usage: $0 --grep SEARCH_TERM"
    exit 1
  fi
  info "!> Searching for '$SEARCH_TERM' in $SSH_FOLDER:"
  echo "----------------------------------------"
  if [ -d "$SSH_FOLDER" ]; then
    verbose_echo "grep -r \"$SEARCH_TERM\" \"$SSH_FOLDER\" 2>/dev/null"
    grep -r "$SEARCH_TERM" "$SSH_FOLDER" 2>/dev/null
    echo "----------------------------------------"
  else
    error "!> No $SSH_FOLDER directory found."
  fi
  exit 0
fi

# Subcommand: Edit SSH config
if [[ "$MODE" == "--edit" || "$MODE" == "-e" ]]; then
  CONFIG_FILE="$SSH_FOLDER/config"
  if [ ! -f "$CONFIG_FILE" ]; then
    warn "!> SSH config file not found. Creating a new one."
    mkdir -p "$SSH_FOLDER"
    touch "$CONFIG_FILE"
    chmod 600 "$CONFIG_FILE"
  fi
  EDITOR=${EDITOR:-nano}
  info "!> Opening SSH config with $EDITOR..."
  verbose_echo "$EDITOR \"$CONFIG_FILE\""
  $EDITOR "$CONFIG_FILE"
  verbose_echo "chmod 600 \"$CONFIG_FILE\""
  chmod 600 "$CONFIG_FILE"
  exit 0
fi

# Subcommand: Edit system SSH config
if [[ "$MODE" == "--editsystem" || "$MODE" == "-es" ]]; then
  SYSTEM_CONFIG="/etc/ssh/sshd_config"
  if [ ! -f "$SYSTEM_CONFIG" ]; then
    error "!> System SSH config file not found at $SYSTEM_CONFIG."
    exit 1
  fi
  EDITOR=${EDITOR:-nano}
  info "!> Opening system SSH config with sudo $EDITOR..."
  verbose_echo "sudo $EDITOR \"$SYSTEM_CONFIG\""
  sudo $EDITOR "$SYSTEM_CONFIG"
  read -p "Do you want to restart the SSH service now? [y/N] " restart
  if [[ "$restart" =~ ^[Yy]$ ]]; then
    if command -v systemctl >/dev/null 2>&1; then
      verbose_echo "sudo systemctl restart ssh"
      sudo systemctl restart ssh
    elif command -v service >/dev/null 2>&1; then
      verbose_echo "sudo service ssh restart"
      sudo service ssh restart
    else
      error "!> Could not determine how to restart SSH service."
    fi
  fi
  exit 0
fi

# Subcommand: Add key to authorized_keys
if [[ "$MODE" == "--addkey" || "$MODE" == "-ak" ]]; then
  KEY_DATA="$SEARCH_TERM"
  [[ "$2" == *=* ]] && KEY_DATA="${2#*=}"
  [[ -z "$KEY_DATA" ]] && KEY_DATA="$3"
  if [[ -z "$KEY_DATA" ]]; then
    error "!> Error: No key provided. Usage: $0 --addkey KEY_FILE_OR_STRING"
    exit 1
  fi
  AUTH_KEYS="$SSH_FOLDER/authorized_keys"
  mkdir -p "$SSH_FOLDER"
  if [ -f "$KEY_DATA" ]; then
    info "!> Adding key from file to authorized_keys..."
    verbose_echo "cat \"$KEY_DATA\" >> \"$AUTH_KEYS\""
    cat "$KEY_DATA" >> "$AUTH_KEYS"
  else
    info "!> Adding key string to authorized_keys..."
    verbose_echo "echo \"$KEY_DATA\" >> \"$AUTH_KEYS\""
    echo "$KEY_DATA" >> "$AUTH_KEYS"
  fi
  verbose_echo "chmod 600 \"$AUTH_KEYS\""
  chmod 600 "$AUTH_KEYS"
  success "!> Key added to authorized_keys."
  exit 0
fi

# Subcommand: Backup SSH files
if [[ "$MODE" == "--backup" || "$MODE" == "-b" ]]; then
  TIMESTAMP=$(date +"%Y%m%d%H%M%S")
  info "!> Backing up SSH files with timestamp $TIMESTAMP..."
  BACKUP_DIR="$SSH_FOLDER/backups"
  mkdir -p "$BACKUP_DIR"
  FILES_TO_BACKUP=("authorized_keys" "known_hosts" "config")
  BACKUP_FILES=()
  for FILE in "${FILES_TO_BACKUP[@]}"; do
    SOURCE_FILE="$SSH_FOLDER/$FILE"
    if [ -f "$SOURCE_FILE" ]; then
      BACKUP_FILE="$BACKUP_DIR/${FILE}-$TIMESTAMP"
      verbose_echo "cp \"$SOURCE_FILE\" \"$BACKUP_FILE\""
      cp "$SOURCE_FILE" "$BACKUP_FILE"
      BACKUP_FILES+=("$BACKUP_FILE")
      success "!> Backed up $FILE to $BACKUP_FILE"
    else
      warn "!> Skipping $FILE (not found)"
    fi
  done
  INFO_FILE="$BACKUP_DIR/jrf-sshtool-info-$TIMESTAMP.txt"
  info "!> Generating SSH keys info report to $INFO_FILE..."
  {
    echo "SSH KEYS INFO REPORT - $(date)"
    echo "----------------------------------------"
    echo "SSH Folder: $SSH_FOLDER"
    echo "Timestamp: $TIMESTAMP"
    echo "----------------------------------------"
    if [ -d "$SSH_FOLDER" ]; then
      find "$SSH_FOLDER" -type f | sort | while read -r KEY_FILE; do
        [[ "$KEY_FILE" =~ ".DS_Store"|".bash_history"|"/backups/" ]] && continue
        CREATED=$(stat -c %y "$KEY_FILE" 2>/dev/null || stat -f "%Sc" "$KEY_FILE" 2>/dev/null)
        MODIFIED=$(stat -c %y "$KEY_FILE" 2>/dev/null || stat -f "%Sm" "$KEY_FILE" 2>/dev/null)
        FILENAME=$(basename "$KEY_FILE")
        if file "$KEY_FILE" | grep -q "private key"; then
          FILE_TYPE="private:"
        elif [[ "$KEY_FILE" == *.pub ]]; then
          FILE_TYPE="public: "
        elif [[ "$KEY_FILE" == *"known_hosts"* ]]; then
          FILE_TYPE="hosts:  "
        elif [[ "$KEY_FILE" == *"config"* ]]; then
          FILE_TYPE="config: "
        elif [[ "$KEY_FILE" == *"authorized_keys"* ]]; then
          FILE_TYPE="auth:   "
        else
          FILE_TYPE="other:  "
        fi
        PREVIEW=$(tail -c 133 "$KEY_FILE" | tr -d '\n')
        echo "$FILE_TYPE $FILENAME"
        echo "        Created: $CREATED"
        echo "        Modified: $MODIFIED"
        if file "$KEY_FILE" | grep -q "text"; then
          echo "        Preview: $PREVIEW"
        else
          echo "        Preview: [binary file]"
        fi
        echo "----------------------------------------"
      done
    else
      echo "No $SSH_FOLDER directory found."
    fi
  } > "$INFO_FILE"
  BACKUP_FILES+=("$INFO_FILE")
  success "!> SSH keys info saved to $INFO_FILE"
  if [ ${#BACKUP_FILES[@]} -gt 0 ]; then
    ARCHIVE_FILE="$BACKUP_DIR/ssh-backup-$TIMESTAMP.tar.gz"
    verbose_echo "tar -czf \"$ARCHIVE_FILE\" ${BACKUP_FILES[*]}"
    tar -czf "$ARCHIVE_FILE" "${BACKUP_FILES[@]}"
    success "!> Compressed backup created: $ARCHIVE_FILE"
    read -p "Do you want to remove individual backup files (keeping only the archive)? [y/N] " remove_files
    if [[ "$remove_files" =~ ^[Yy]$ ]]; then
      verbose_echo "rm ${BACKUP_FILES[*]}"
      rm "${BACKUP_FILES[@]}"
      success "!> Individual backup files removed"
    fi
  else
    warn "!> No files were backed up"
  fi
  exit 0
fi

# Subcommand: Convert SSH key format
if [[ "$MODE" == "--convert" || "$MODE" == "-cv" ]]; then
  KEY_FILE="$SEARCH_TERM"
  [[ "$2" == *=* ]] && KEY_FILE="${2#*=}"
  [[ -z "$KEY_FILE" || ! -f "$KEY_FILE" ]] && { error "!> Error: Key file not found. Usage: $0 --convert KEY_FILE"; exit 1; }
  info "!> Converting SSH key: $KEY_FILE"
  echo "!> Available conversions:"
  echo "1) PEM to PPK (PuTTY)"
  echo "2) PPK to PEM (OpenSSH)"
  echo "3) SSH2 to OpenSSH"
  echo "4) OpenSSH to PKCS8"
  echo "5) Password-protect key"
  echo "6) Remove password from key"
  read -p "Select conversion (1-6): " conversion
  case "$conversion" in
    1) command -v puttygen >/dev/null 2>&1 || { error "!> Error: puttygen not found. Install putty-tools package."; exit 1; }
       OUTPUT_FILE="${KEY_FILE%.pem}.ppk"; verbose_echo "puttygen \"$KEY_FILE\" -o \"$OUTPUT_FILE\""; puttygen "$KEY_FILE" -o "$OUTPUT_FILE"; success "!> Converted to: $OUTPUT_FILE" ;;
    2) command -v puttygen >/dev/null 2>&1 || { error "!> Error: puttygen not found. Install putty-tools package."; exit 1; }
       OUTPUT_FILE="${KEY_FILE%.ppk}.pem"; verbose_echo "puttygen \"$KEY_FILE\" -O private-openssh -o \"$OUTPUT_FILE\""; puttygen "$KEY_FILE" -O private-openssh -o "$OUTPUT_FILE"; success "!> Converted to: $OUTPUT_FILE" ;;
    3) OUTPUT_FILE="${KEY_FILE%.ssh2}.openssh"; verbose_echo "ssh-keygen -i -f \"$KEY_FILE\" > \"$OUTPUT_FILE\""; ssh-keygen -i -f "$KEY_FILE" > "$OUTPUT_FILE"; success "!> Converted to: $OUTPUT_FILE" ;;
    4) OUTPUT_FILE="${KEY_FILE%.key}.pkcs8"; verbose_echo "ssh-keygen -p -N '' -m PKCS8 -f \"$KEY_FILE\""; ssh-keygen -p -N "" -m PKCS8 -f "$KEY_FILE"; success "!> Converted in place: $KEY_FILE" ;;
    5) verbose_echo "ssh-keygen -p -f \"$KEY_FILE\""; ssh-keygen -p -f "$KEY_FILE"; success "!> Password protection added to: $KEY_FILE" ;;
    6) verbose_echo "ssh-keygen -p -N '' -f \"$KEY_FILE\""; ssh-keygen -p -N "" -f "$KEY_FILE"; success "!> Password removed from: $KEY_FILE" ;;
    *) error "!> Invalid option selected."; exit 1 ;;
  esac
  chmod 600 "${OUTPUT_FILE:-$KEY_FILE}" 2>/dev/null
  exit 0
fi

# Subcommand: Generate SSH aliases
if [[ "$MODE" == "--alias" || "$MODE" == "-al" ]]; then
  CONFIG_FILE="$SSH_FOLDER/config"
  [ ! -f "$CONFIG_FILE" ] && { error "!> SSH config file not found."; exit 1; }
  info "!> Generating SSH aliases from config..."
  echo -e "${BLUE}# SSH aliases generated from $CONFIG_FILE${NC}\n"
  verbose_echo "grep -i '^Host ' \"$CONFIG_FILE\" | grep -v '*'"
  grep -i "^Host " "$CONFIG_FILE" | grep -v "*" | while read -r hostline; do
    host=$(awk '{print $2}' <<< "$hostline")
    [[ "$host" =~ [*?] ]] && continue
    alias_name=$(tr '.-' '__' <<< "$host")
    echo -e "${GREEN}alias ssh_$alias_name='ssh $host'${NC}"
  done
  exit 0
fi

# Subcommand: Restart SSH agent
if [[ "$MODE" == "--restart" || "$MODE" == "-r" ]]; then
  info "!> Recycling SSH agent..."
  pgrep -u "$USER" ssh-agent >/dev/null 2>&1 && { warn "!!> Killing existing agents..."; verbose_echo "pkill -u $USER ssh-agent"; pkill -u "$USER" ssh-agent; }
  info "!!> Executing ssh-agent..."
  verbose_echo "eval \$(ssh-agent -s)"; eval "\$(ssh-agent -s)"
  command -v systemctl >/dev/null 2>&1 && { info "!!> Restarting SSH services..."; verbose_echo "sudo systemctl restart ssh"; sudo systemctl restart ssh || true; }
  success "!> Agent PID: $(pgrep -u "$USER" ssh-agent || echo 'NOT RUNNING')"
  exit 0
fi

# Subcommand: Show SSH services status
if [[ "$MODE" == "--service" || "$MODE" == "-s" ]]; then
  info "!> SSH agent & services:"
  verbose_echo "pgrep -u $USER ssh-agent"
  info "!> SSH agent PID: $(pgrep -u "$USER" ssh-agent || echo 'NOT RUNNING')"
  echo "...to view all ssh-agent PIDS: pgrep -u \$USER ssh-agent | less"
  if command -v systemctl >/dev/null 2>&1; then
    info "!> SSH systemctl services:"; echo "!------------------------->"
    verbose_echo "sudo systemctl status ssh"
    sudo systemctl status ssh
    echo "!------------------------->"; echo "... to print statuses in less: sudo systemctl status ssh | less"
  else
    warn "!> Skipping systemctl, command not found"
  fi
  exit 0
fi

# Subcommand: Ensure ssh-agent running
if [[ "$MODE" == "--agent" || "$MODE" == "-a" ]]; then
  info "!> Checking for SSH agent..."
  if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    warn "!!> Agent not found, starting ssh-agent..."
    verbose_echo "eval \$(ssh-agent -s)"; eval "\$(ssh-agent -s)"
  else
    success "!> SSH agent is already running"
  fi
  info "!> SSH agent PID: $(pgrep -u "$USER" ssh-agent || echo 'NOT RUNNING')"
  exit 0
fi

# Subcommand: Create SSH folder and fix permissions
if [[ "$MODE" == "--create" || "$MODE" == "-c" ]]; then
  info "!!> Creating $SSH_FOLDER and fixing permissions..."
  verbose_echo "mkdir -p $SSH_FOLDER"; mkdir -p "$SSH_FOLDER"
  verbose_echo "chmod 700 $SSH_FOLDER"; chmod 700 "$SSH_FOLDER"
  verbose_echo "chown $(id -u):$(id -g) $SSH_FOLDER"; chown "$(id -u)":"$(id -g)" "$SSH_FOLDER"
  verbose_echo "$0 \"$SSH_FOLDER\" --fix"; "$0" "$SSH_FOLDER" --fix
  exit 0
fi

# Subcommand: Fix SSH folder permissions
if [[ "$MODE" == "--fix" || "$MODE" == "-f" ]]; then
  info "!> Fixing SSH permissions for $SSH_FOLDER..."
  if [ -d "$SSH_FOLDER" ]; then
    verbose_echo "chmod 700 $SSH_FOLDER"; chmod 700 "$SSH_FOLDER"
    verbose_echo "find $SSH_FOLDER -type d -exec chmod 700 {} \;"; find "$SSH_FOLDER" -type d -exec chmod 700 {} \;
    verbose_echo "find $SSH_FOLDER -type f -name '*.pub' -exec chmod 644 {} \;"; find "$SSH_FOLDER" -type f -name "*.pub" -exec chmod 644 {} \;
    verbose_echo "find $SSH_FOLDER -type f -name 'authorized_keys' -exec chmod 600 {} \;"; find "$SSH_FOLDER" -type f -name "authorized_keys" -exec chmod 600 {} \;
    verbose_echo "find $SSH_FOLDER -type f -name 'config' -exec chmod 600 {} \;"; find "$SSH_FOLDER" -type f -name "config" -exec chmod 600 {} \;
    verbose_echo "find $SSH_FOLDER -type f -name 'known_hosts' -exec chmod 644 {} \;"; find "$SSH_FOLDER" -type f -name "known_hosts" -exec chmod 644 {} \;
    verbose_echo "find $SSH_FOLDER -type f ! -name '*.pub' ! -name 'authorized_keys' ! -name 'config' ! -name 'known_hosts' -exec chmod 600 {} \;";
    find "$SSH_FOLDER" -type f ! -name "*.pub" ! -name "authorized_keys" ! -name "config" ! -name "known_hosts" -exec chmod 600 {} \;
    verbose_echo "chown -R $(id -u):$(id -g) $SSH_FOLDER"; chown -R "$(id -u)":"$(id -g)" "$SSH_FOLDER"
    success "!> permissions fixed."
  else
    error "!> no $SSH_FOLDER directory to fix."
  fi
  exit 0
fi

# Subcommand: Add keys from SSH folder
if [[ "$MODE" == "--keys" || "$MODE" == "-k" ]]; then
  if [[ "$SSH_FOLDER" != "$HOME/.ssh" && "$1" != "--keys" && "$1" != "-k" ]]; then
    info "!> Adding all private keys from $SSH_FOLDER..."
  else
    verbose_echo "SSH_FOLDER=$HOME/.ssh"; SSH_FOLDER="$HOME/.ssh"
    info "!> Adding all private keys from $SSH_FOLDER..."
  fi
  if ! pgrep -u "$USER" ssh-agent >/dev/null; then
    info "Starting ssh-agent..."; verbose_echo "eval \$(ssh-agent -s)"; eval "\$(ssh-agent -s)"
  fi
  find "$SSH_FOLDER" -type f | while read -r KEY_FILE; do
    if file "$KEY_FILE" | grep -qE 'private key'; then
      verbose_echo "chmod 600 \"$KEY_FILE\""; chmod 600 "$KEY_FILE"
      verbose_echo "chown $(id -u):$(id -g) \"$KEY_FILE\""; chown "$(id -u)":"$(id -g)" "$KEY_FILE"
      if [[ "$MODE" == "--prompt" || "$MODE" == "-p" ]]; then
        info "!> Adding key (with prompt if needed): $KEY_FILE"; verbose_echo "ssh-add \"$KEY_FILE\""
        if ssh-add "$KEY_FILE"; then ((KEYS_ADDED++)); success "[added with prompt] $KEY_FILE"; else ((KEYS_ERRORS++)); error "[error adding] $KEY_FILE"; fi
      else
        verbose_echo "ssh-add -q \"$KEY_FILE\" </dev/null"; if ssh-add -q "$KEY_FILE" </dev/null; then ((KEYS_ADDED++)); success "[added] $KEY_FILE"; else ((KEYS_SKIPPED++)); warn "[skipped/password needed] $KEY_FILE"; fi
      fi
    fi
  done
  if $SUMMARY; then
    echo; info "--- Summary ---"; success "Added: $KEYS_ADDED"; warn "Skipped: $KEYS_SKIPPED"; error "Errors: $KEYS_ERRORS"
  fi
  exit 0
fi

# Unknown command
error "!> Unknown command: $MODE"
info "!> Use --help to see available commands"
exit 1
