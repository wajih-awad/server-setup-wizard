# server-setup-wizard


# 🧙‍♂️ Server Setup Wizard

**Server Setup Wizard** is a Bash script that simplifies the installation of common web development tools and services on Linux servers. The script offers a guided, interactive installation process that allows users to select which components they want to install.

---

## 📌 Features

- **Bilingual Support**: Interface available in Arabic and English  
- **Smart Detection**: Checks if programs are already installed before attempting installation  
- **Modular Design**: Easy to add or remove software packages  
- **User-Friendly**: Simple yes/no prompts for each installation step  

---

## 📦 Included Software

The script can install the following software packages:

- NGINX web server  
- Snapd package manager  
- Certbot (for SSL certificates)  
- Node.js  
- MySQL database server  
- PHP  

---

## ⚙️ How It Works

1. The script begins by asking the user to select a language preference (Arabic or English)  
2. It then presents a series of installation prompts for each software package  
3. For each prompt, the user can respond with `yes/y` or `no/n`  
4. Before installing, the script checks if the software is already present  
5. If the software is not installed, it executes the appropriate installation commands  

---

## 🔧 Extending the Script

Adding new software packages is straightforward — simply add a new entry to the `programs` array following this format:

```bash
"ProgramName:command-to-check:installation-command"
```
For example, to add Python:
```bash
"Python:python3:sudo apt install python3 -y"
``` 
🚀 Usage
```bash
chmod +x server-setup-wizard.sh
sudo ./server-setup-wizard.sh
