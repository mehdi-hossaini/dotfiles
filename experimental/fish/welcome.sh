#!/usr/bin/env bash

# ==============================================================================
# Enhanced Welcome Script 2026
# Optimized for Fish Shell with modern features and better performance
# Requires: Nerd Font (e.g., JetBrains Mono Nerd Font)
# ==============================================================================

# --- Configuration ---
SHOW_ASCII=true
SHOW_TIP=true
SHOW_QUOTE=true
SHOW_WEATHER=false
SHOW_GIT_STATUS=true
CACHE_TIMEOUT=300

# --- Colors (ANSI Escape Codes) ---
RESET='\033[0m'
BOLD='\033[1m'
DIM='\033[2m'
ITALIC='\033[3m'
FG_BLUE='\033[38;5;75m'
FG_GREEN='\033[38;5;119m'
FG_PURPLE='\033[38;5;141m'
FG_CYAN='\033[38;5;87m'
FG_ORANGE='\033[38;5;214m'
FG_RED='\033[38;5;203m'
FG_YELLOW='\033[38;5;228m'
BG_BLUE='\033[48;5;24m'
BG_GREEN='\033[48;5;22m'

# --- Icons (Nerd Fonts - JetBrains Mono compatible) ---
ICON_USER=""
ICON_HOST="󰒋"
ICON_OS="󰌽"
ICON_KERNEL="󰕚"
ICON_UPTIME="󰔟"
ICON_SHELL="󰞷"
ICON_CPU="󰘚"
ICON_MEM="󰍛"
ICON_DISK="󰋊"
ICON_NETWORK="󰖩"
ICON_GIT="󰊢"
ICON_TIME="󱑍"
ICON_TEMP="󰔏"
ICON_TIP="󰌶"

# --- Cache Directory ---
CACHE_DIR="${HOME}/.cache/welcome_script"
mkdir -p "$CACHE_DIR" 2>/dev/null

# --- Helper Functions ---

safe_exec() {
    local output
    output=$("$@" 2>/dev/null)
    if [[ $? -eq 0 && -n "$output" ]]; then
        echo "$output"
    else
        echo "N/A"
    fi
}

print_line() {
    local label="$1"
    local value="$2"
    local color="${3:-$FG_BLUE}"
    
    if [[ ${#value} -gt 55 ]]; then
        value="${value:0:52}..."
    fi
    
    printf "${DIM}%s${RESET} ${color}%s${RESET}\n" "$label" "$value"
}

cached_exec() {
    local cache_key="$1"
    local cache_file="${CACHE_DIR}/${cache_key}"
    shift
    
    if [[ -f "$cache_file" ]]; then
        local age=$(($(date +%s) - $(stat -c %Y "$cache_file" 2>/dev/null || stat -f %m "$cache_file" 2>/dev/null || echo 0)))
        if [[ $age -lt $CACHE_TIMEOUT ]]; then
            cat "$cache_file"
            return
        fi
    fi
    
    local result
    result=$(safe_exec "$@")
    echo "$result" > "$cache_file"
    echo "$result"
}

get_os() {
    if [[ "$(uname)" == "Darwin" ]]; then
        local version
        version=$(sw_vers -productVersion 2>/dev/null || echo "Unknown")
        echo "macOS ${version}"
    elif [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "${PRETTY_NAME:-${NAME:-Unknown Linux}}"
    else
        uname -s
    fi
}

get_uptime() {
    if command -v uptime &> /dev/null; then
        if [[ "$(uname)" == "Darwin" ]]; then
            uptime | sed -E 's/.*up ([^,]+).*/\1/' | xargs
        else
            uptime -p 2>/dev/null | sed 's/up //' || uptime | sed -E 's/.*up ([^,]+).*/\1/' | xargs
        fi
    else
        echo "N/A"
    fi
}

get_memory() {
    if [[ "$(uname)" == "Darwin" ]]; then
        local page_size=$(pagesize 2>/dev/null || echo 4096)
        local pages_active=$(vm_stat | awk '/Pages active/ {print $3}' | tr -d '.')
        local pages_wired=$(vm_stat | awk '/Pages wired down/ {print $4}' | tr -d '.')
        local pages_free=$(vm_stat | awk '/Pages free/ {print $3}' | tr -d '.')
        
        if [[ -n "$pages_active" && -n "$pages_wired" ]]; then
            local used_mb=$(( (pages_active + pages_wired) * page_size / 1024 / 1024 ))
            local total_mb=$(( (pages_active + pages_wired + pages_free) * page_size / 1024 / 1024 ))
            echo "${used_mb} MB / ${total_mb} MB"
        else
            echo "N/A"
        fi
    else
        if command -v free &> /dev/null; then
            free -h 2>/dev/null | awk '/^Mem:/ {print $3 " / " $2}' || echo "N/A"
        else
            echo "N/A"
        fi
    fi
}

get_cpu() {
    cached_exec "cpu_info" bash -c '
        if [[ "$(uname)" == "Darwin" ]]; then
            sysctl -n machdep.cpu.brand_string 2>/dev/null || echo "Unknown CPU"
        else
            grep -m 1 "model name" /proc/cpuinfo 2>/dev/null | cut -d":" -f2 | xargs || echo "Unknown CPU"
        fi
    '
}

get_disk() {
    df -h / 2>/dev/null | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}' || echo "N/A"
}

get_cpu_temp() {
    if [[ "$(uname)" == "Darwin" ]]; then
        if command -v osx-cpu-temp &> /dev/null; then
            osx-cpu-temp | grep -o '[0-9.]*°C' | head -1
        else
            echo "N/A"
        fi
    else
        if [[ -f /sys/class/thermal/thermal_zone0/temp ]]; then
            local temp=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
            if [[ -n "$temp" ]]; then
                echo "$((temp / 1000))°C"
            else
                echo "N/A"
            fi
        else
            echo "N/A"
        fi
    fi
}

get_network() {
    if command -v ping &> /dev/null; then
        if ping -c 1 -W 1 8.8.8.8 &> /dev/null; then
            echo "Connected"
        else
            echo "Offline"
        fi
    else
        echo "Unknown"
    fi
}

get_git_status() {
    if command -v git &> /dev/null && git rev-parse --git-dir &> /dev/null 2>&1; then
        local branch
        branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "detached")
        local status
        status=$(git status --porcelain 2>/dev/null | wc -l | xargs)
        
        if [[ "$status" -eq 0 ]]; then
            echo "✓ ${branch} (clean)"
        else
            echo "● ${branch} (${status} changes)"
        fi
    else
        echo ""
    fi
}

get_quote() {
    local quotes=(
        "\"Code is poetry.\" - Unknown"
        "\"Make it work, make it right, make it fast.\" - Kent Beck"
        "\"Simplicity is the soul of efficiency.\" - Austin Freeman"
        "\"First, solve the problem. Then, write the code.\" - John Johnson"
        "\"The best error message is the one that never shows up.\" - Thomas Fuchs"
        "\"Clean code always looks like it was written by someone who cares.\" - Robert C. Martin"
        "\"Any fool can write code that a computer can understand. Good programmers write code that humans can understand.\" - Martin Fowler"
        "\"Programs must be written for people to read, and only incidentally for machines to execute.\" - Harold Abelson"
    )
    echo "${quotes[$RANDOM % ${#quotes[@]}]}"
}

# Performance: Calculate once
CURRENT_USER=$(whoami)
HOSTNAME=$(hostname)
OS_INFO=$(get_os)
KERNEL_INFO=$(uname -r)
UPTIME_INFO=$(get_uptime)
CPU_INFO=$(get_cpu)
MEM_INFO=$(get_memory)
DISK_INFO=$(get_disk)
TEMP_INFO=$(get_cpu_temp)
NET_INFO=$(get_network)

# --- Main Output ---

if [[ "$SHOW_ASCII" == true ]]; then
    printf "${FG_PURPLE}${BOLD}"
    cat << "EOF"
 ▄     ▄ ▄▄▄▄▄▄▄ ▄▄▄     ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄▄ 
█ █ ▄ █ █       █   █   █       █       █  █▄█  █       █
█ ██ ██ █    ▄▄▄█   █   █       █   ▄   █       █    ▄▄▄█
█       █   █▄▄▄█   █   █     ▄▄▄█  █ █  █       █   █▄▄▄ 
█       █    ▄▄▄█   █▄▄▄█    █  █  █▄█  █       █    ▄▄▄█
█   ▄   █   █▄▄▄█       █    █▄▄█       █ ██▄██ █   █▄▄▄ 
█▄▄█ █▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄▄▄▄▄▄▄█▄█   █▄█▄▄▄▄▄▄▄█
EOF
    printf "${RESET}\n"
fi

# System Information Section
printf "${BOLD}${BG_BLUE}  SYSTEM  ${RESET} ${BOLD}${FG_CYAN}Overview${RESET}\n"
printf "${DIM}  ────────────────────────────────────────────${RESET}\n"

print_line "  $ICON_USER User     :" "${CURRENT_USER}@${HOSTNAME}" "$FG_BLUE"
print_line "  $ICON_HOST Host     :" "$HOSTNAME" "$FG_GREEN"
print_line "  $ICON_OS OS       :" "$OS_INFO" "$FG_GREEN"
print_line "  $ICON_KERNEL Kernel   :" "$KERNEL_INFO" "$FG_CYAN"
print_line "  $ICON_UPTIME Uptime   :" "$UPTIME_INFO" "$FG_ORANGE"
print_line "  $ICON_SHELL Shell    :" "${SHELL##*/} ${FISH_VERSION:-}" "$FG_PURPLE"
print_line "  $ICON_NETWORK Network  :" "$NET_INFO" "$FG_CYAN"

# Hardware Section
printf "\n${BOLD}${BG_GREEN}  HARDWARE  ${RESET} ${BOLD}${FG_CYAN}Resources${RESET}\n"
printf "${DIM}  ────────────────────────────────────────────${RESET}\n"

print_line "  $ICON_CPU CPU      :" "$CPU_INFO" "$FG_BLUE"
print_line "  $ICON_MEM Memory   :" "$MEM_INFO" "$FG_BLUE"
print_line "  $ICON_DISK Disk     :" "$DISK_INFO" "$FG_BLUE"

if [[ "$TEMP_INFO" != "N/A" ]]; then
    print_line "  $ICON_TEMP Temp     :" "$TEMP_INFO" "$FG_ORANGE"
fi

# Git Status (if in a repository)
if [[ "$SHOW_GIT_STATUS" == true ]]; then
    GIT_STATUS=$(get_git_status)
    if [[ -n "$GIT_STATUS" ]]; then
        printf "\n${BOLD}${FG_PURPLE}  $ICON_GIT Repository${RESET}\n"
        printf "${DIM}  ────────────────────────────────────────────${RESET}\n"
        print_line "  Branch   :" "$GIT_STATUS" "$FG_PURPLE"
    fi
fi

# Footer with Date/Time
printf "\n${DIM}  ────────────────────────────────────────────${RESET}\n"
printf "${FG_CYAN}  $ICON_TIME $(date '+%A, %d %B %Y - %H:%M:%S')${RESET}\n"

# Random Tip
if [[ "$SHOW_TIP" == true ]]; then
    tips=(
        "Run 'fish_config' to customize your prompt visually"
        "Press -> (Right Arrow) to accept autosuggestions"
        "Press Ctrl+R to search command history interactively"
        "Use 'cd -' to toggle between last two directories"
        "Type 'abbr --add gp git push' for permanent shortcuts"
        "Press Ctrl+L to clear screen (or type 'clear')"
        "Use 'mkdir -p path/to/nested/dirs' for deep structures"
        "Fish highlights invalid commands in red before execution"
        "Use 'grep -r \"pattern\" .' for recursive text search"
        "Try 'htop' or 'btop' for beautiful process monitoring"
        "Press Alt+Enter to safely paste multiline commands"
        "Use 'git status' regularly to track project changes"
        "Try 'funcedit function_name' to edit Fish functions"
        "Use 'ssh-keygen -t ed25519' for modern SSH keys"
        "Press Esc then . to insert last argument of previous command"
        "Use 'curl -fsSL url | sh' for piped installations"
        "Try 'tmux' or 'zellij' for terminal multiplexing"
        "Press Ctrl+D to close terminal (or type 'exit')"
        "Use 'Ctrl+U' to cut line before cursor"
        "Use 'Ctrl+K' to cut line after cursor"
        "Use 'Ctrl+Y' to paste previously cut text"
        "Run 'history merge' to sync history across sessions"
        "Use 'set -Ux VAR value' for universal variables"
        "Try 'zoxide' or 'z' for intelligent directory jumping"
        "Use 'pushd' and 'popd' for directory stack navigation"
        "Use 'ls -lAh' to see all files with human sizes"
        "Try 'eza' or 'lsd' as modern replacements for 'ls'"
        "Use 'tree -L 2' to visualize directory structure"
        "Use 'rm -i' or 'trash' for safer file deletion"
        "Use 'rsync -av' for efficient file synchronization"
        "Run 'du -sh *' to see directory sizes"
        "Use 'df -h' to check disk space on all mounts"
        "Try 'fd' as a faster alternative to 'find'"
        "Use 'rg' (ripgrep) as a faster alternative to 'grep'"
        "Use 'bat' instead of 'cat' for syntax highlighting"
        "Use 'head -n 20 file' to see first 20 lines"
        "Use 'tail -f file' to watch log files in real-time"
        "Use 'wc -l file' to count lines in a file"
        "Pipe commands with '|' to chain operations"
        "Use '!!' to reference the last command"
        "Use 'jobs' to list background processes"
        "Use 'fg' to bring background job to foreground"
        "Press Ctrl+Z to suspend current process"
        "Use 'kill %1' to terminate job number 1"
        "Try 'procs' as a modern replacement for 'ps'"
        "Use 'sed -i \"s/old/new/g\" file' for in-place replacement"
        "Use 'awk' for powerful text column processing"
        "Use 'diff -u file1 file2' for unified diff format"
        "Try 'delta' for beautiful git diffs"
        "Use 'git log --oneline --graph' for visual history"
        "Use 'git stash' to temporarily save uncommitted changes"
        "Use 'git checkout -b feature' to create new branch"
        "Use 'git switch -' to toggle between last two branches"
        "Run 'neofetch' or 'fastfetch' for system overview"
        "Use 'ping -c 4 google.com' to test connectivity"
        "Use 'ssh -i key.pem user@host' for key-based auth"
        "Use 'scp -r dir user@host:/path' to copy recursively"
        "Try 'watch' to run commands periodically"
        "Use 'ip addr' or 'ifconfig' for network info"
        "Run 'systemctl status service' to check service health"
        "Use 'journalctl -f' to follow system logs"
        "Try 'duf' as a modern replacement for 'df'"
        "Use 'ncdu' for interactive disk usage analysis"
        "Use 'chmod 755 file' for executable permissions"
        "Use 'chown user:group file' to change ownership"
        "Use 'tar -czf archive.tar.gz dir/' to compress"
        "Use 'tar -xzf archive.tar.gz' to extract"
        "Try 'gping' for graphical ping"
        "Use 'which command' to find command location"
        "Use 'type command' to see how Fish interprets it"
        "Run 'fish --version' to check shell version"
        "Edit '~/.config/fish/config.fish' for startup scripts"
        "Run 'source ~/.config/fish/config.fish' to reload config"
        "Use 'string split' for string manipulation in Fish"
        "Try 'math \"2 + 2\"' for calculations in Fish"
        "Use 'random' to generate random numbers"
        "Press Alt+D to delete word after cursor"
        "Use 'history delete --exact \"command\"' to remove entries"
        "Run 'fish_update_completions' to refresh completions"
        "Try 'starship' for a beautiful cross-shell prompt"
        "Use 'docker ps' to list running containers"
        "Use 'kubectl get pods' to list Kubernetes pods"
        "Try 'lazygit' for a terminal UI for git"
        "Use 'jq' to parse and format JSON"
        "Try 'yq' for YAML processing"
        "Use 'fzf' for fuzzy finding files and history"
        "Learn keybindings: they're massive productivity boosters"
        "Keep your config files in version control"
        "Document your custom functions and aliases"
        "Read man pages: they're incredibly detailed"
        "Join terminal/shell communities for tips"
        "Master one tool at a time, don't overwhelm yourself"
        "Backup your dotfiles regularly"
        "Experiment in test directories first"
        "Use '--help' flag to quickly understand commands"
        "Practice terminal shortcuts daily for muscle memory"
        "Enjoy the power of the command line!"
    )
    random_tip=${tips[$RANDOM % ${#tips[@]}]}
    printf "${FG_GREEN}  $ICON_TIP ${random_tip}${RESET}\n"
fi

# Random Quote
if [[ "$SHOW_QUOTE" == true ]]; then
    printf "${FG_YELLOW}${ITALIC}  $(get_quote)${RESET}\n"
fi

printf "\n"
