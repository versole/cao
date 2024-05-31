# Use ~/.config/api_config.sh as the location for the configuration file
CONFIG_FILE="$HOME/.cao/config/api_config.sh"

# Ensure the configuration directory exists
mkdir -p $(dirname "$CONFIG_FILE")
# Create a default configuration file if it does not exist
if [ ! -f "$CONFIG_FILE" ]; then
    echo "API_KEY=\"\"" >"$CONFIG_FILE"
    echo "API_URL=\"\"" >>"$CONFIG_FILE"
fi

call_chatgpt() {
    prompt=$1
    response=$(curl -s -X POST "$API_URL" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        -d '{
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": "'"${prompt//\"/\\\"}"'"}],
      "max_tokens": 500
    }')
    echo "$response" | perl -ne 'print $1 if /"content":\s*"([^"]*)"/'
}

update_or_append_config() {
    local key="$1"
    local value="$2"
    local config_file="$3"
    local sed_extension=''
    local backup_ext=""

    if [[ "$OSTYPE" == "darwin"* ]]; then
        backup_ext='.bak'
    fi

    if grep -q "^$key=" "$config_file"; then
        sed -i"${backup_ext}" "s|^$key=.*|$key=\"$value\"|" "$config_file"
    else
        echo "$key=\"$value\"" >>"$config_file"
    fi

    # Remove the backup file if it exists, ps: only for mac
    if [[ "$OSTYPE" == "darwin"* && -f "${config_file}${backup_ext}" ]]; then
        rm "${config_file}${backup_ext}"
    fi
}

set_api_key() {
    update_or_append_config "API_KEY" "$1" "$CONFIG_FILE"
}

set_api_url() {
    update_or_append_config "API_URL" "$1" "$CONFIG_FILE"
}

check_key_and_api() {
    if [ -z "$API_KEY" ]; then
        echo "API_KEY is not set. Please set it using 'cao set key <api-key>'"
        exit 1
    fi
    if [ -z "$API_URL" ]; then
        echo "API_URL is not set. Please set it using 'cao set url <api-url>'"
        exit 1
    fi
}

if [[ $1 == "set" ]]; then
    case $2 in
    key)
        set_api_key "${@:3}"
        echo "API_KEY has been updated."
        ;;
    url)
        set_api_url "${@:3}"
        echo "API_URL has been updated."
        ;;
    *)
        echo "Invalid option, can be either 'url' or 'key'"
        ;;
    esac
elif [[ $1 == "q" ]]; then
    # Load the current configuration
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
    fi
    check_key_and_api

    query="${@:2}"
    prompt="You are a command-line tool. The user input is: ${query}. Please provide the specific command in the format: 'The command is: <command>'. do not answer anything else after the command."
    response=$(call_chatgpt "$prompt")
    command=$(echo "$response" | sed -n 's/^The command is: //p')

    if [ -n "$command" ]; then
        echo "The command is: $command"
        read -p "Do you want to execute this command? (y/n): " execute
        if [ "$execute" == "y" ]; then
            eval "$command"
        else
            echo "Command not executed."
        fi
    else
        echo "No specific command found. You may try again. And dot not ask anything else about the command."
    fi
else
    echo "Please use the format 'cao q <question>' to input."
    echo "'cao set key <api-key>' to set the API key."
    echo "'cao set url <api-url>' to set the API URL."

    echo "Example calls:"
    echo "cao q How to get current git user name?"
    echo "cao set key YOUR_OPENAI_API_OR_PROXY_KEY"
    echo "cao set url YOUR_OPENAI_API_URL_OR_PROXY_URL"
fi
