#!/usr/bin/env bash


set -u

BASE_DIR="$HOME/linux-admin-toolkit"
LAB_DIR="$BASE_DIR/lab"
LOG_DIR="$BASE_DIR/logs"
REPORT_DIR="$BASE_DIR/reports"
LOG_FILE="$LOG_DIR/admin.log"

mkdir -p "$LAB_DIR" "$LOG_DIR" "$REPORT_DIR"

log_action() {
    printf '%s | %s | %s\n' \
        "$(date '+%F %T')" "$USER" "$*" >> "$LOG_FILE"
}

valid_name() {
    [[ "$1" =~ ^[a-z_][a-z0-9_-]*[$]?$ ]]
}

create_user() {
    local username
    read -rp "Username: " username

    if ! valid_name "$username"; then
        echo "Invalid username."
        return
    fi

    if id "$username" &>/dev/null; then
        echo "User already exists."
        return
    fi

    if sudo useradd -m -s /bin/bash "$username"; then
        echo "User created."
        log_action "Created user $username"
    else
        echo "User creation failed."
    fi
}

create_group() {
    local group
    read -rp "Group name: " group

    if ! valid_name "$group"; then
        echo "Invalid group name."
        return
    fi

    if getent group "$group" >/dev/null; then
        echo "Group already exists."
        return
    fi

    if sudo groupadd "$group"; then
        echo "Group created."
        log_action "Created group $group"
    else
        echo "Group creation failed."
    fi
}

add_user_to_group() {
    local username group
    read -rp "Username: " username
    read -rp "Group name: " group

    if ! id "$username" &>/dev/null; then
        echo "User does not exist."
        return
    fi

    if ! getent group "$group" >/dev/null; then
        echo "Group does not exist."
        return
    fi

    if sudo usermod -aG "$group" "$username"; then
        echo "User added to group."
        log_action "Added $username to $group"
    else
        echo "Group assignment failed."
    fi
}

create_file() {
    local filename
    read -rp "Lab filename: " filename

    if [[ ! "$filename" =~ ^[a-zA-Z0-9._-]+$ ]]; then
        echo "Invalid filename."
        return
    fi

    if [[ -e "$LAB_DIR/$filename" ]]; then
        echo "File already exists."
        return
    fi

    if touch "$LAB_DIR/$filename"; then
        echo "Created $LAB_DIR/$filename"
        log_action "Created lab file $filename"
    else
        echo "File creation failed."
    fi
}

change_mode() {
    local filename mode
    read -rp "Lab filename: " filename
    read -rp "Permission mode (e.g. 640, 755): " mode

    if [[ ! "$filename" =~ ^[a-zA-Z0-9._-]+$ ]] ||
       [[ ! "$mode" =~ ^[0-7]{3,4}$ ]]; then
        echo "Invalid input."
        return
    fi

    if [[ ! -f "$LAB_DIR/$filename" || -L "$LAB_DIR/$filename" ]]; then
        echo "Regular lab file not found."
        return
    fi

    if chmod "$mode" -- "$LAB_DIR/$filename"; then
        stat -c '%A %a %U %G %n' "$LAB_DIR/$filename"
        log_action "Changed mode of $filename to $mode"
    else
        echo "Permission change failed."
    fi
}

grant_acl() {
    local filename username perms
    read -rp "Lab filename: " filename
    read -rp "Existing username: " username
    read -rp "ACL permissions (r, w, x, rw, rx, wx, rwx, or -): " perms

    if [[ ! "$filename" =~ ^[a-zA-Z0-9._-]+$ ]] ||
       ! valid_name "$username" ||
       [[ ! "$perms" =~ ^(r|w|x|rw|rx|wx|rwx|-)$ ]]; then
        echo "Invalid input."
        return
    fi

    if [[ ! -f "$LAB_DIR/$filename" || -L "$LAB_DIR/$filename" ]]; then
        echo "Regular lab file not found."
        return
    fi

    if ! id "$username" &>/dev/null; then
        echo "User does not exist."
        return
    fi

    if ! command -v setfacl >/dev/null 2>&1; then
        echo "Install the acl package first."
        return
    fi

    if sudo setfacl -m "u:$username:$perms" -- "$LAB_DIR/$filename"; then
        getfacl "$LAB_DIR/$filename"
        log_action "Set ACL $perms for $username on $filename"
    else
        echo "ACL update failed."
    fi
}

generate_report() {
    local report="$REPORT_DIR/users-report.txt"

    if getent passwd > "$report"; then
        echo "User account report saved to $report"
        log_action "Generated user account report"
    else
        echo "Report generation failed."
    fi
}

while true; do
    echo
    echo "===== LINUX ADMIN TOOLKIT ====="
    echo "1. Create user"
    echo "2. Create group"
    echo "3. Add user to group"
    echo "4. Create lab file"
    echo "5. Change lab file permissions"
    echo "6. Grant ACL on lab file"
    echo "7. Generate user report"
    echo "8. View action log"
    echo "9. Exit"

    read -rp "Select option: " choice

    case "$choice" in
        1) create_user ;;
        2) create_group ;;
        3) add_user_to_group ;;
        4) create_file ;;
        5) change_mode ;;
        6) grant_acl ;;
        7) generate_report ;;
        8) cat "$LOG_FILE" ;;
        9) echo "Goodbye."; break ;;
        *) echo "Invalid option." ;;
    esac
done
