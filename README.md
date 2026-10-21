# 🐧 Linux User & Permission Management System

A Bash-based Linux administration project that simplifies user and group management, file permission configuration, ACL administration, and activity logging.

## 📌 Project Overview

The **Linux User & Permission Management System** is a command-line administration toolkit designed to automate common Linux system administration tasks using Bash scripting.

It provides a menu-driven interface for managing users, groups, file permissions, and access control lists (ACLs). The project also records administrative actions in a log file and generates a basic user account report.

## 🎯 Objectives

- Automate Linux user and group management.
- Manage file ownership and permissions.
- Practise Linux security concepts and access control.
- Reduce repetitive manual administration tasks.
- Learn Bash scripting, input validation, and logging.

## ✨ Features

- **User Management:** Create Linux user accounts.
- **Group Management:** Create groups and manage group membership.
- **File Management:** Create test files in a dedicated lab directory.
- **Permission Management:** Change file permissions using numeric modes.
- **ACL Management:** Grant user-specific permissions to lab files.
- **Activity Logging:** Record administrative actions with timestamps.
- **User Reports:** Generate a basic account report.
- **Menu-Driven Interface:** Perform operations through an interactive terminal menu.

## 🛠️ Technologies Used

- Linux
- Bash Shell Scripting
- Linux User and Group Administration
- File Permissions (`chmod`, `chown`, `chgrp`)
- Access Control Lists (`setfacl`, `getfacl`)
- Linux Utilities (`id`, `getent`, `stat`)
- Git and GitHub

## 📂 Project Structure

```text
linux-admin-toolkit/
├── README.md
├── scripts/
│   └── admin.sh
├── logs/
│   └── admin.log
├── reports/
│   └── users-report.txt
├── tests/
│   └── test-permissions.sh
└── lab/
    └── report.txt
```

*Note: The log, report, and lab files are generated when the corresponding operations are performed. The test script may still need to be implemented.*

## ⚙️ Prerequisites

- A Linux environment, such as Ubuntu.
- Bash shell.
- `sudo` privileges for administrative operations.
- ACL utilities for ACL features.

Install ACL utilities on Ubuntu:

```bash
sudo apt update
sudo apt install acl
```

## 🚀 Installation and Usage

### 1. Clone the repository

After uploading the project to GitHub, replace the placeholder URL below with your repository URL.

```bash
git clone https://github.com/abhinav-1818/linux-admin-toolkit.git
cd linux-admin-toolkit
```

### 2. Make the script executable

```bash
chmod 750 scripts/admin.sh
```

### 3. Check Bash syntax

```bash
bash -n scripts/admin.sh
```

### 4. Run the application

```bash
./scripts/admin.sh
```

### 5. Select an operation

Use the interactive menu to create users and groups, manage lab files, change permissions, grant ACL entries, generate reports, and inspect the action log.

## 🔐 Linux Concepts Practised

| Concept | Purpose |
|---|---|
| Users and groups | Manage identities and team membership |
| UID and GID | Identify users and groups |
| `chmod` | Change file permission bits |
| `chown` | Change file ownership |
| `chgrp` | Change group ownership |
| SUID | Set-user-ID permission bit |
| SGID | Set-group-ID permission bit |
| Sticky bit | Restrict deletion and renaming in shared directories |
| ACL | Configure additional user/group access entries |
| Bash functions | Organize reusable script operations |
| Logging | Record administrative actions |

*Note: SUID, SGID, sticky-bit management, and default ACL automation are planned enhancements unless they have been implemented and tested in the current version.*

## 🧪 Testing and Verification

Verify user and group information:

```bash
id labrahul
getent group labdevelopers
```

Inspect file permissions:

```bash
ls -l ~/linux-admin-toolkit/lab
stat ~/linux-admin-toolkit/lab/report.txt
```

Inspect ACL entries:

```bash
getfacl ~/linux-admin-toolkit/lab/report.txt
```

Inspect the activity log:

```bash
cat ~/linux-admin-toolkit/logs/admin.log
```

Replace example usernames, group names, and file paths with those used in your environment.

## 🛡️ Security Considerations

- Run the project in a test VM or dedicated lab environment.
- Use `sudo` only when administrative privileges are necessary.
- Validate usernames, filenames, and permission inputs.
- Never test account deletion or permission changes on production users or files.
- Review file ownership and ACL entries after changes.
- Treat the current activity log as a basic record, not tamper-resistant auditing.

## 📚 Learning Outcomes

By completing this project, I practise Linux user administration, group management, standard file permissions, ACLs, Bash automation, input validation, logging, and troubleshooting.

## 🔮 Future Enhancements

- Automate SUID, SGID, and sticky-bit configuration.
- Support default ACLs for shared directories.
- Add bulk user creation from a CSV file.
- Add user, group, and permission reports.
- Improve error handling and security validation.
- Add automated test cases.
- Improve logging and auditability.

## 👨‍💻 Author

**Abhinav Dongrajkar**

MCA Student | Learning Linux, AWS, Cloud Computing & DevOps

---

⭐ If you find this project useful, consider starring the repository on GitHub.

