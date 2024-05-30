#!/bin/bash

# GitHub上的cao.sh脚本的URL路径
SCRIPT_URL="https://raw.githubusercontent.com/versole/cao/master/cao.sh"

# 目标目录
INSTALL_DIR="$HOME/.cao/"

# 脚本名称
SCRIPT_NAME="cao"

# 判断是否安装过
check_existing() {
    if command -v "$SCRIPT_NAME" >/dev/null; then
        echo "It appears that '$SCRIPT_NAME' is already installed. Exiting."
        exit 1
    fi
}

check_existing

# 下载cao.sh脚本
curl -o "$INSTALL_DIR/$SCRIPT_NAME" "$SCRIPT_URL"

# 添加可执行权限
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# 判断是zsh还是bash, 向对应的配置文件添加PATH
if [ -n "$ZSH_VERSION" ]; then
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$HOME/.bashrc"
fi

# 重新加载配置文件
source "$HOME/.zshrc"
source "$HOME/.bashrc"


# 检查cao.sh脚本是否已正确安装并可执行
if command -v "$SCRIPT_NAME" >/dev/null; then
    echo "'$SCRIPT_NAME' installed successfully and is available on the PATH."
else
    echo "Installation failed. Please check your permissions or path and try again."
fi
