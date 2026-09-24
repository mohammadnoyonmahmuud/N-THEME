#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════
#  N-THEME — Premium Termux Theme Installer
#  Author : Mohammad Noyon Mahmud
#  License: MIT
# ═══════════════════════════════════════════════════════════

set -e

# ───────────────────────────────────────────────────────────
#  PREMIUM COLORS (Bright — No Lowlight)
# ───────────────────────────────────────────────────────────
RESET='\033[0m'
BOLD='\033[1m'

GREEN='\033[1;38;5;46m'
NEON='\033[1;38;5;118m'
LIME='\033[1;38;5;154m'
CYAN='\033[1;38;5;51m'
YELLOW='\033[1;38;5;226m'
RED='\033[1;38;5;196m'
WHITE='\033[1;38;5;255m'
MAGENTA='\033[1;38;5;201m'

# ───────────────────────────────────────────────────────────
#  PATHS
# ───────────────────────────────────────────────────────────
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
TERMUX_DIR="$HOME/.termux"
N_THEME_DIR="$HOME/.n-theme"
CONFIG_FILE="$N_THEME_DIR/config"
BASHRC="$HOME/.bashrc"
BACKUP_DIR="$N_THEME_DIR/backup"

mkdir -p "$TERMUX_DIR" "$N_THEME_DIR" "$BACKUP_DIR"

# ───────────────────────────────────────────────────────────
#  HELPERS
# ───────────────────────────────────────────────────────────
line() {
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

show_header() {
    clear
    echo ""
    echo -e "${GREEN}${BOLD}"
    echo "   ███╗   ██╗    ████████╗██╗  ██╗███████╗███╗   ███╗███████╗"
    echo "   ████╗  ██║    ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝"
    echo "   ██╔██╗ ██║       ██║   ███████║█████╗  ██╔████╔██║█████╗  "
    echo "   ██║╚██╗██║       ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  "
    echo "   ██║ ╚████║       ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗"
    echo "   ╚═╝  ╚═══╝       ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝"
    echo -e "${RESET}"
    echo -e "${NEON}         ⚡ PREMIUM TERMUX BANNER & THEME INSTALLER ⚡${RESET}"
    echo -e "${LIME}                ✦ Crafted with ❤  by Noyon ✦${RESET}"
    line
    echo ""
}

show_menu() {
    echo -e "${CYAN}  ┌─────────────────────────────────────────────┐${RESET}"
    echo -e "${CYAN}  │${RESET}  ${YELLOW}${BOLD}✦  N-THEME  INSTALLER  MENU  ✦${RESET}            ${CYAN}│${RESET}"
    echo -e "${CYAN}  ├─────────────────────────────────────────────┤${RESET}"
    echo -e "${CYAN}  │${RESET}                                             ${CYAN}│${RESET}"
    echo -e "${CYAN}  │${RESET}   ${GREEN}[1]${RESET}  📦  Download necessary files          ${CYAN}│${RESET}"
    echo -e "${CYAN}  │${RESET}   ${GREEN}[2]${RESET}  🖼️   Setup Banner                       ${CYAN}│${RESET}"
    echo -e "${CYAN}  │${RESET}   ${GREEN}[3]${RESET}  💻  Setup Name                         ${CYAN}│${RESET}"
    echo -e "${CYAN}  │${RESET}   ${RED}[4]${RESET}  🚪  Exit                               ${CYAN}│${RESET}"
    echo -e "${CYAN}  │${RESET}                                             ${CYAN}│${RESET}"
    echo -e "${CYAN}  └─────────────────────────────────────────────┘${RESET}"
    echo ""
    echo -ne "${YELLOW}  ➤ Choose option [1-4]: ${RESET}"
}

step_print() {
    local num="$1"
    local total="$2"
    local msg="$3"
    printf "${CYAN}  ▶ [%s/%s]${RESET} ${WHITE}%s${RESET}" "$num" "$total" "$msg"
}

step_ok() {
    echo -e " ${GREEN}✅${RESET}"
}

step_fail() {
    echo -e " ${RED}❌${RESET}"
}

# ───────────────────────────────────────────────────────────
#  INDIVIDUAL STEPS
# ───────────────────────────────────────────────────────────
step_update_packages() {
    step_print 1 8 "Updating package list..."
    pkg update -y >/dev/null 2>&1 || pkg update -y
    step_ok
}

step_install_deps() {
    step_print 2 8 "Installing dependencies..."
    pkg install -y git curl figlet python ble.sh >/dev/null 2>&1 || \
    pkg install -y git curl figlet python >/dev/null 2>&1
    step_ok
}

step_download_theme() {
    step_print 3 8 "Downloading theme files..."
    cp "$REPO_DIR/colors.properties" "$TERMUX_DIR/colors.properties" 2>/dev/null || true
    step_ok
}

step_download_font() {
    step_print 4 8 "Downloading fonts..."
    if [ -f "$REPO_DIR/font.ttf" ]; then
        cp "$REPO_DIR/font.ttf" "$TERMUX_DIR/font.ttf"
    fi
    step_ok
}

step_apply_colors() {
    step_print 5 8 "Applying colors..."
    termux-reload-settings >/dev/null 2>&1 || true
    step_ok
}

step_setup_banner() {
    step_print 6 8 "Setting up banner..."
    touch "$CONFIG_FILE"
    if ! grep -q "^BANNER_NAME=" "$CONFIG_FILE" 2>/dev/null; then
        echo "BANNER_NAME=NOYON" >> "$CONFIG_FILE"
    fi
    step_ok
}

step_setup_prompt() {
    step_print 7 8 "Setting up prompt..."
    touch "$CONFIG_FILE"
    if ! grep -q "^USER_NAME=" "$CONFIG_FILE" 2>/dev/null; then
        echo "USER_NAME=NOYON" >> "$CONFIG_FILE"
    fi
    step_ok
}

step_finalize() {
    step_print 8 8 "Finalizing..."
    # Backup .bashrc
    [ -f "$BASHRC" ] && cp "$BASHRC" "$BACKUP_DIR/bashrc.bak" 2>/dev/null || true

    # Remove old N-THEME block
    if [ -f "$BASHRC" ]; then
        sed -i '/# >>> N-THEME >>>/,/# <<< N-THEME <<</d' "$BASHRC"
    fi

    # Append new block
    cat >> "$BASHRC" << 'EOF'
# >>> N-THEME >>>
[ -f "$HOME/.n-theme/config" ] && source "$HOME/.n-theme/config"

# Premium Prompt
export PS1='\[\e[1;38;5;46m\]TERMUX\[\e[0m\]@\[\e[1;38;5;51m\]${USER_NAME:-NOYON}\[\e[0m\]\$ '

# Banner
if [ -f "$HOME/.n-theme/banner.txt" ]; then
    cat "$HOME/.n-theme/banner.txt"
fi

# Auto-suggestion (ble.sh)
if [ -f "$PREFIX/share/blesh/ble.sh" ]; then
    source "$PREFIX/share/blesh/ble.sh" --attach=none 2>/dev/null || true
fi
# <<< N-THEME <<<
EOF

    step_ok
}

# ───────────────────────────────────────────────────────────
#  FULL INSTALL (Option 1)
# ───────────────────────────────────────────────────────────
do_full_install() {
    show_header
    echo -e "${NEON}  🚀 Starting full installation...${RESET}"
    echo ""
    line
    echo ""

    step_update_packages
    step_install_deps
    step_download_theme
    step_download_font
    step_apply_colors
    step_setup_banner
    step_setup_prompt
    step_finalize

    echo ""
    line
    echo ""
    echo -e "${GREEN}  ✅ All 8 steps completed successfully!${RESET}"
    echo -e "${LIME}  ➤ Now run: ${WHITE}source ~/.bashrc${RESET}"
    echo -e "${LIME}  ➤ Or close and reopen Termux.${RESET}"
    echo ""
    echo -ne "${YELLOW}  Press Enter to continue...${RESET}"
    read -r
}

# ───────────────────────────────────────────────────────────
#  SETUP BANNER (Option 2)
# ───────────────────────────────────────────────────────────
do_setup_banner() {
    show_header
    echo -e "${NEON}  🖼️  Banner Setup${RESET}"
    echo ""
    line
    echo ""
    echo -ne "${YELLOW}  ➤ Enter your name: ${RESET}"
    read -r name

    if [ -z "$name" ]; then
        echo -e "${RED}  ❌ Name cannot be empty.${RESET}"
        sleep 2
        return
    fi

    # Convert to UPPERCASE
    upper_name=$(echo "$name" | tr '[:lower:]' '[:upper:]')

    # Update config
    sed -i '/^BANNER_NAME=/d' "$CONFIG_FILE" 2>/dev/null || true
    echo "BANNER_NAME=$upper_name" >> "$CONFIG_FILE"

    # Generate banner with figlet
    if command -v figlet >/dev/null 2>&1; then
        figlet -f standard "$upper_name" > "$N_THEME_DIR/banner.txt" 2>/dev/null
    else
        echo "$upper_name" > "$N_THEME_DIR/banner.txt"
    fi

    echo ""
    echo -e "${GREEN}  ✅ Banner saved as: ${WHITE}$upper_name${RESET}"
    echo ""
    sleep 2
}

# ───────────────────────────────────────────────────────────
#  SETUP NAME (Option 3)
# ───────────────────────────────────────────────────────────
do_setup_name() {
    show_header
    echo -e "${NEON}  💻 Prompt Name Setup${RESET}"
    echo ""
    line
    echo ""
    echo -ne "${YELLOW}  ➤ Enter your name: ${RESET}"
    read -r name

    if [ -z "$name" ]; then
        echo -e "${RED}  ❌ Name cannot be empty.${RESET}"
        sleep 2
        return
    fi

    upper_name=$(echo "$name" | tr '[:lower:]' '[:upper:]')

    sed -i '/^USER_NAME=/d' "$CONFIG_FILE" 2>/dev/null || true
    echo "USER_NAME=$upper_name" >> "$CONFIG_FILE"

    echo ""
    echo -e "${GREEN}  ✅ Prompt set to: ${WHITE}TERMUX@$upper_name\\$${RESET}"
    echo ""
    sleep 2
}

# ───────────────────────────────────────────────────────────
#  MAIN LOOP
# ───────────────────────────────────────────────────────────
while true; do
    show_header
    show_menu
    read -r choice
    echo ""

    case "$choice" in
        1) do_full_install ;;
        2) do_setup_banner ;;
        3) do_setup_name ;;
        4) echo -e "${LIME}  ✦ Goodbye! ✦${RESET}"; exit 0 ;;
        *) echo -e "${RED}  ❌ Invalid option. Try again.${RESET}"; sleep 1 ;;
    esac
done
