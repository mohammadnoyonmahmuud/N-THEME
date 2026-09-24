#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════
#  N-THEME — Uninstaller
#  Author : Mohammad Noyon Mahmud
#  License: MIT
# ═══════════════════════════════════════════════════════════

RESET='\033[0m'
BOLD='\033[1m'
GREEN='\033[1;38;5;46m'
NEON='\033[1;38;5;118m'
CYAN='\033[1;38;5;51m'
YELLOW='\033[1;38;5;226m'
RED='\033[1;38;5;196m'
WHITE='\033[1;38;5;255m'

BASHRC="$HOME/.bashrc"
TERMUX_DIR="$HOME/.termux"
N_THEME_DIR="$HOME/.n-theme"
BACKUP_DIR="$N_THEME_DIR/backup"

clear
echo ""
echo -e "${RED}${BOLD}"
echo "   ╔═══════════════════════════════════════════╗"
echo "   ║      ✦  N-THEME  UNINSTALLER  ✦           ║"
echo "   ╚═══════════════════════════════════════════╝"
echo -e "${RESET}"
echo ""
echo -e "${YELLOW}  ⚠  This will remove N-THEME from your Termux.${RESET}"
echo ""
echo -ne "${YELLOW}  ➤ Are you sure? (y/N): ${RESET}"
read -r confirm

if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}  ✦ Cancelled. Nothing removed.${RESET}"
    exit 0
fi

echo ""
echo -e "${CYAN}  ▶ Removing N-THEME block from .bashrc...${RESET}"
if [ -f "$BASHRC" ]; then
    # Backup before editing
    cp "$BASHRC" "$BASHRC.before-uninstall" 2>/dev/null || true
    sed -i '/# >>> N-THEME >>>/,/# <<< N-THEME <<</d' "$BASHRC"
fi
echo -e "${GREEN}  ✅ Done${RESET}"

echo -e "${CYAN}  ▶ Removing config directory...${RESET}"
rm -rf "$N_THEME_DIR"
echo -e "${GREEN}  ✅ Done${RESET}"

echo -e "${CYAN}  ▶ Resetting Termux colors...${RESET}"
if [ -f "$TERMUX_DIR/colors.properties" ]; then
    rm -f "$TERMUX_DIR/colors.properties"
fi
if [ -f "$TERMUX_DIR/font.ttf" ]; then
    rm -f "$TERMUX_DIR/font.ttf"
fi
termux-reload-settings >/dev/null 2>&1 || true
echo -e "${GREEN}  ✅ Done${RESET}"

echo ""
echo -e "${GREEN}${BOLD}  ✦ N-THEME has been successfully removed.${RESET}"
echo -e "${WHITE}  ➤ Run: ${GREEN}source ~/.bashrc${RESET}"
echo -e "${WHITE}  ➤ Or restart Termux for full reset.${RESET}"
echo ""
echo -ne "${YELLOW}  Press Enter to exit...${RESET}"
read -r
