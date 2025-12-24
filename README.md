# Fedora System Admin Master 🚀
**A Modular Bash Framework for System Health, Security Auditing, and Automation.**

![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)
![Platform](https://img.shields.io/badge/Platform-Fedora%20/%20RHEL-blue.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📋 Project Overview
This project is an advanced, production-ready Bash script designed to automate critical system administration tasks on Fedora-based environments. It focuses on the "Set and Forget" philosophy, ensuring system reliability through automated audits and backups.

## ✨ Key Features
* **Security Auditing:** Automated status checks for **SELinux** and **Firewalld**.
* **Intelligent Updates:** Filters and identifies critical security patches via `dnf`.
* **Resource Monitoring:** Real-time disk usage analysis with configurable alert thresholds.
* **Automated Backups:** Secure, compressed archiving of `/etc` configuration files.
* **Clean Code Architecture:** Developed using modular functions and industry-standard error handling (SRP principles).
* **Centralized Logging:** Detailed event logging in `/var/log/sys_audit` for troubleshooting.

## 🛠 Installation & Usage
Clone the repository and grant execution permissions:

```bash
git clone [https://github.com/Hassan-Ghasemzadeh/AutomatedSystemAuditor.git](https://github.com/Hassan-Ghasemzadeh/AutomatedSystemAuditor.git)
cd Hassan-Ghasemzadeh
chmod +x fedora_pro_audit.sh
Run the main auditor (requires sudo):

Bash

0 2 * * * /path/to/fedora_pro_audit.sh
🤝 Contribution
Contributions are welcome! If you'd like to add features like Slack/Telegram notifications or cloud backup integration, feel free to open a Pull Request.

Developed by [Hassan Ghasemzadeh] Passionate about Linux Automation and DevOps Excellence.
