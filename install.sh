#!/usr/bin/env bash

# URL path for the cao.sh script on GitHub
SCRIPT_URL="https://raw.githubusercontent.com/versole/cao/master/cao.sh"

# Target directory for installation
INSTALL_DIR="$HOME/.cao/"

# Script name
SCRIPT_NAME="cao"

# Check if it's already installed
check_existing() {
    if command -v "$SCRIPT_NAME" >/dev/null; then
        echo "It appears that '$SCRIPT_NAME' is already installed. Exiting."
        exit 1
    fi
}

check_existing

# Ensure the configuration directory exists
mkdir -p "$INSTALL_DIR"

# Download the cao.sh script
curl -o "$INSTALL_DIR$SCRIPT_NAME" "$SCRIPT_URL"

# Add execution permissions to the script
chmod +x "$INSTALL_DIR$SCRIPT_NAME"

# Determine if using zsh or bash and append to respective config file
if [ -n "$ZSH_VERSION" ]; then
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.bashrc"
fi

echo "\n\n\033[32mPlease run 'source ~/.zshrc' or 'source ~/.bashrc' to start using cao.\033[0m"