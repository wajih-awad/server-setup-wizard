#!/bin/bash

# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "Please run this script as root"
    exit 1
fi

# تحميل nvm إذا كان موجودًا
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"


# Select language: 1 for Arabic, 2 for English
echo "اختر اللغة / Select language:"
echo "1. العربية / Arabic"
echo "2. English / الإنجليزية"
read -p "> " lang



# Define language strings
if [ "$lang" == "1" ]; then
    LANG_ALREADY_INSTALLED="مثبت بالفعل."
    LANG_PLEASE_ENTER="الرجاء إدخال 'yes' أو 'no'"
    LANG_INSTALLING="جاري تثبيت"
else
    LANG_ALREADY_INSTALLED="is already installed."
    LANG_PLEASE_ENTER="Please enter 'yes' or 'no'"
    LANG_INSTALLING="Installing"
fi

# Define array of programs to install with their properties
# Format: "name:command:installation_command"
declare -a programs=(
    "Node.js:node:curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt install -y nodejs"
    "NGINX:nginx:sudo apt install nginx -y"
    "snap:snap:sudo apt install snapd -y"
    "certbot:certbot:sudo snap install --classic certbot && sudo ln -s /snap/bin/certbot /usr/bin/certbot"
    "MySQL:mysql:sudo apt install mysql-server -y" 
    "PHP:php:sudo apt install php -y"
)

# Function to ask yes/no questions
ask() {
    local prompt="$1"
    local response
    
    while true; do
        read -p "$prompt" response
        response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
        
        # Universal responses (both languages)
        if [ "$response" == "yes" ] || [ "$response" == "y" ]; then
            return 0  # Yes - proceed with installation
        elif [ "$response" == "no" ] || [ "$response" == "n" ]; then
            return 1  # No - skip installation
        else
            echo "$LANG_PLEASE_ENTER"
        fi
    done
}

# Function to install a program
install_program() {
    local program_info="$1"
    
    # Split the program info
    IFS=':' read -r name command install_cmd <<< "$program_info"
    
    # Create question based on language
    local question
    if [ "$lang" == "1" ]; then
        question="هل تريد تثبيت $name؟ (yes/no): "
    else
        question="Do you want to install $name? (yes/no): "
    fi
    
    # Ask if user wants to install this program
    if ask "$question"; then
        # Check if program is already installed

        if ! command -v $command >/dev/null 2>&1; then
            echo "$LANG_INSTALLING $name..."
            eval "$install_cmd"
        else
            echo "$name $LANG_ALREADY_INSTALLED"
        fi
    fi
}

# Loop through all programs in the array and install them
for program in "${programs[@]}"; do
    install_program "$program"
done