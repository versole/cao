<div align="center">
<h1 align="center">CAO</h1>

[中文文档](https://github.com/versole/cao/blob/master/README.zh_CN.MD)

</div>

# CAO Command-Line Tool

**!!!Only support macos!!!** 

## Introduction
CAO is a command-line tool that directly fetches corresponding commands based on user descriptions, by interacting with the ChatGPT API.

## Installation

To install the CAO tool, execute the following command in your terminal:

``` bash
curl -o- https://raw.githubusercontent.com/versole/cao/master/install.sh | bash

or

curl -o- https://raw.githubusercontent.com/versole/cao/master/install.sh | zsh

```
This script will download and run the `install.sh` script from the CAO repository.

``` bash 
source ~/.bashrc
or
source ~/.zshrc 

source <your-shell-profile-file>
```

## Configuration
After installation, set up your API key and URL to enable the tool to communicate with the ChatGPT API:

Here is a GitHub repository that provides 100 free calls per day (3.5 turbo) by binding your GitHub account: [chatanywhere](https://github.com/chatanywhere/GPT_API_free)
``` bash
cao set key <your-api-key>
cao set url <your-api-url>
```

## Usage
Ask for a specific command based on a description:
``` bash
cao q <description-of-your-task> # e.g., cao q List all branches in Git
```

For example, to find out how to list all branches in Git:
cao q List all branches in Git
The tool will return the specific command you need.

## Commands Overview
- `cao set key <api-key>`: Save your API key. e.g., `cao set key 12345678-1234-1234-1234-123456789012`
- `cao set url <api-url>`: Save the API endpoint URL. e.g., `cao set url https://api.openai.com/v1/chat/completions`
- `cao q <description>`: Describe the task or question, and CAO will provide the specific command.

## Note
Make sure you have set the API key and API URL correctly before using CAO to ask for commands.
