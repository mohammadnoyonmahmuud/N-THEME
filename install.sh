#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════
#  N-THEME — Premium Termux Banner & Theme Changer
#  Author : Mohammad Noyon Mahmud
#  GitHub : https://github.com/mohammadnoyonmahmuud
#  Repo   : https://github.com/mohammadnoyonmahmuud/N-THEME.git
#  License: MIT
# ═══════════════════════════════════════════════════════════

R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;93m'
B='\033[1;94m'
C='\033[1;96m'
W='\033[1;97m'
M='\033[1;95m'
RS='\033[0m'

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
GITHUB_USER="mohammadnoyonmahmuud"
GITHUB_REPO="N-THEME"
AUTHOR_NAME="Mohammad Noyon Mahmud"

term_width=$(tput cols)
BOX_WIDTH=$(( term_width > 60 ? 58 : term_width - 2 ))
margin=$(( (term_width - BOX_WIDTH) / 2 ))
left_pad=$(printf '%*s' "$margin" "")

# ───────────────────────────────────────────────────────────
#  SIMPLE BANNER
# ───────────────────────────────────────────────────────────
banner() {
    clear
    echo -e ""
    echo -e "${G}        --[ ${W}PREMIUM TERMUX BANNER & THEME CHANGER ${G}]--  ${Y}BY ${C}NOYON${RS}"
    echo -e "${G}  ==============================================${RS}"
    echo -e ""
}

ensure_dependencies() {
    echo -e "${Y}[*] CHECKING DEPENDENCIES...${RS}"
    local missing=()
    for pkg in git figlet curl wget unzip xz-utils; do
        if ! command -v "$pkg" &>/dev/null; then
            missing+=("$pkg")
        fi
    done
    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${Y}[*] INSTALLING: ${missing[*]}...${RS}"
        pkg update -y && pkg install "${missing[@]}" -y
    fi
}

# ───────────────────────────────────────────────────────────
#  OPTION 01 — NECESSARY SETUP
# ───────────────────────────────────────────────────────────
do_full_setup() {
    banner
    echo -e "${Y}[*] RUNNING NECESSARY SETUP...${RS}"
    echo ""
    ensure_dependencies
    mkdir -p ~/.termux
    [ -f "$REPO_DIR/.object/.termux.properties" ] && cp "$REPO_DIR/.object/.termux.properties" ~/.termux/termux.properties
    [ -f "$REPO_DIR/.object/.colors.properties" ] && cp "$REPO_DIR/.object/.colors.properties" ~/.termux/colors.properties

    if [ -f "$REPO_DIR/.object/ANSI Shadow.flf" ]; then
        mkdir -p "$PREFIX/share/figlet"
        cp "$REPO_DIR/.object/ANSI Shadow.flf" "$PREFIX/share/figlet/ASCII-Shadow.flf"
    fi

    if command -v termux-reload-settings &>/dev/null; then
        termux-reload-settings
    fi
    echo -e "${G}[√] NECESSARY SETUP COMPLETED!${RS}"
    sleep 2
    menu
}

# ───────────────────────────────────────────────────────────
#  OPTION 02 — SETUP YOUR NAME (Auto)
# ───────────────────────────────────────────────────────────
do_bash_quick_setup() {
    banner
    echo -e "${C}  ───[${W} SETUP YOUR NAME ${C}]───${RS}"
    echo ""
    echo -e "${G}  [✓] FIGLET FONT     : ASCII-SHADOW"
    echo -e "${G}  [✓] BANNER COLOR    : LOLCAT (RAINBOW)"
    echo -e "${G}  [✓] PROMPT SYMBOL   : \$"
    echo -e "${G}  [✓] PROMPT LAYOUT   : GIT-AWARE"
    echo ""
    echo -ne "${Y}  [?]${W} ENTER YOUR NAME (DEFAULT: NOYON): ${RS}"
    read -r username
    [ -z "$username" ] && username="NOYON"

    ensure_dependencies

    if [ ! -d ~/.local/share/blesh ]; then
        echo -e "${Y}[*] INSTALLING BLE.SH (AUTO-SUGGESTION)...${RS}"
        mkdir -p /tmp
        curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz -o /tmp/ble-nightly.tar.xz 2>/dev/null
        if [ -f /tmp/ble-nightly.tar.xz ]; then
            tar -xJf /tmp/ble-nightly.tar.xz -C "$HOME/.termux/"
            mkdir -p ~/.local/share/blesh
            cp -a "$HOME/.termux/ble-nightly/"* ~/.local/share/blesh/
            rm -rf "$HOME/.termux/ble-nightly" /tmp/ble-nightly.tar.xz
        fi
    fi

    if ! command -v lolcat &>/dev/null; then
        pkg install ruby -y >/dev/null 2>&1
        gem install lolcat >/dev/null 2>&1 || true
    fi

    apply_shell_customizations "bash" "$username" "ASCII-Shadow" "lolcat" "\$" "git-aware"
}

# ───────────────────────────────────────────────────────────
#  OPTION 03 — SETUP AI (Auto JetBrains Mono)
# ───────────────────────────────────────────────────────────
do_font_auto_setup() {
    banner
    echo -e "${C}  ───[${W} SETUP AI ${C}]───${RS}"
    echo ""

    if [ -f "$HOME/.termux/font.ttf" ]; then
        echo -e "${G}  [✓] FONT ALREADY INSTALLED!${RS}"
        echo -e "${Y}  ➤ SKIPPING DOWNLOAD.${RS}"
        echo ""
        echo -ne "${Y}  PRESS ENTER TO CONTINUE...${RS}"
        read -r
        menu
        return
    fi

    echo -e "${Y}  [*] INSTALLING JETBRAINS MONO NERD FONT...${RS}"

    ensure_dependencies
    mkdir -p "$HOME/.termux"
    local temp_zip="$HOME/.termux/temp_font.zip"

    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip" -o "${temp_zip}" 2>/dev/null

    if [ ! -f "${temp_zip}" ]; then
        echo -e "${R}  [!] DOWNLOAD FAILED. CHECK INTERNET.${RS}"
        sleep 2
        menu
        return
    fi

    local extract_dir="$HOME/.termux/temp_extract"
    rm -rf "$extract_dir"
    mkdir -p "$extract_dir"
    unzip -o -q "${temp_zip}" "*.ttf" -d "$extract_dir" 2>/dev/null

    local regular_font=$(find "$extract_dir" -name "JetBrainsMonoNerdFont-Regular.ttf" -type f | head -1)

    if [ -n "$regular_font" ] && [ -f "$regular_font" ]; then
        mv "$regular_font" "$HOME/.termux/font.ttf"
        rm -rf "$extract_dir" "$temp_zip"
        command -v termux-reload-settings &>/dev/null && termux-reload-settings
        echo ""
        echo -e "${G}  [✓] JETBRAINS MONO INSTALLED SUCCESSFULLY!${RS}"
    else
        echo -e "${R}  [!] FONT VARIANT NOT FOUND.${RS}"
        rm -rf "$extract_dir" "$temp_zip"
    fi

    echo ""
    echo -ne "${Y}  PRESS ENTER TO CONTINUE...${RS}"
    read -r
    menu
}

# ───────────────────────────────────────────────────────────
#  APPLY SHELL CUSTOMIZATIONS
# ───────────────────────────────────────────────────────────
apply_shell_customizations() {
    local shell=$1
    local username=$2
    local fig_font=$3
    local color_style=$4
    local prompt_sym=$5
    local prompt_layout=$6

    ensure_dependencies

    local figlet_dir=""
    if [ -n "$PREFIX" ]; then
        figlet_dir="$PREFIX/share/figlet"
    else
        figlet_dir="$HOME/.local/share/figlet"
    fi
    mkdir -p "$figlet_dir"

    if [ -f "$REPO_DIR/.object/ANSI Shadow.flf" ]; then
        cp "$REPO_DIR/.object/ANSI Shadow.flf" "$figlet_dir/ASCII-Shadow.flf"
    fi

    local banner_script="$HOME/.n-theme-banner.sh"
    cat << 'EOF' > "$banner_script"
#!/bin/bash
clear
BOX_WIDTH=56
cyan='\033[0;36m'
reset='\033[0m'
EOF

    echo "FIGLET_DIR=\"$figlet_dir\"" >> "$banner_script"

    cat << 'EOF' >> "$banner_script"
print_center() { local text="$1"; local len=${#text}; local space_len=$(( (BOX_WIDTH - 2 - len) / 2 )); printf "${cyan} ║%*s${reset}%s${cyan}%*s║${reset}\n" $space_len "" "$text" $(( BOX_WIDTH - 2 - len - space_len )) ""; }
draw_line() { local char=$1; local end=$2; printf "${cyan} %s" "$char"; for ((i=0; i<BOX_WIDTH-2; i++)); do printf "═"; done; printf "%s${reset}\n" "$end"; }

draw_line '╔' '╗'
print_center ''
EOF

    if [ "$color_style" = "lolcat" ]; then
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$username' 2>/dev/null | lolcat 2>/dev/null || printf '  $username\\n'" >> "$banner_script"
    else
        echo "echo -e '\\033[1;32m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$username' 2>/dev/null || printf '  $username\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    fi

    cat << EOF >> "$banner_script"
print_center ''
print_center 'USER: $username'
print_center 'N-THEME ACTIVE'
print_center ''
draw_line '╚' '╝'
EOF

    chmod +x "$banner_script"

    if [ "$shell" = "bash" ]; then
        [ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.bak

        cat << 'EOF' > ~/.bashrc
[[ ${USER-} ]] || export USER=$(id -un)
export LANG=en_US.UTF-8
export LC_CTYPE=POSIX

bind 'set enable-bracketed-paste off' 2>/dev/null

[[ -f ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh

bash ~/.n-theme-banner.sh

alias l='ls -la'
alias ll='ls -l'
EOF

        cat > "$HOME/.blerc" << 'EOF'
function ble/util/notify-broken-locale {
  return 0
}
bleopt edit_magic_accept=
bleopt edit_magic_multiline=
bleopt term_bracketed_paste_mode=off
ble-bind -m emacs -f C-m 'accept-line'
ble-bind -m vi_imap -f C-m 'accept-line'
ble-bind -m vi_nmap -f C-m 'accept-line'
EOF

        cat > "$HOME/.inputrc" << 'EOF'
set enable-bracketed-paste off
set editing-mode emacs
"\C-m": accept-line
EOF

        cat << 'EOF' >> ~/.bashrc
set_bash_prompt() {
    local EXIT="$?"
    local GREEN="\[\033[1;32m\]"
    local RED="\[\033[1;31m\]"
    local YELLOW="\[\033[1;33m\]"
    local BLUE="\[\033[1;34m\]"
    local MAGENTA="\[\033[1;35m\]"
    local RESET="\[\033[0m\]"
    local git_info=""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        git_info=" ${YELLOW}GIT:(${branch})${RESET}"
    fi
    local arrow="${GREEN}__SYMBOL__"
    if [ "$EXIT" -ne 0 ]; then
        arrow="${RED}__SYMBOL__"
    fi
    PS1="${MAGENTA}__USERNAME__ ${BLUE}\w${git_info} ${arrow} ${RESET}"
}
PROMPT_COMMAND=set_bash_prompt
EOF

        sed -i "s/__USERNAME__/$username/g" ~/.bashrc
        sed -i "s/__SYMBOL__/$prompt_sym/g" ~/.bashrc
    fi

    echo ""
    echo -e "${G}[√] SETUP COMPLETED SUCCESSFULLY!${RS}"
    echo -e "${Y}  ➤ CLOSE AND REOPEN TERMUX TO SEE CHANGES.${RS}"
    echo ""
    echo -ne "${Y}  PRESS ENTER TO CONTINUE...${RS}"
    read -r
    menu
}

# ───────────────────────────────────────────────────────────
#  AUTO UPDATE (Option 04 — runs directly)
# ───────────────────────────────────────────────────────────
do_update() {
    banner
    echo -e "${Y}[*] AUTO UPDATING N-THEME...${RS}"
    echo ""

    cd "$REPO_DIR" 2>/dev/null

    if [ ! -d .git ]; then
        echo -e "${R}[!] NOT A GIT REPOSITORY.${RS}"
        sleep 2
        menu
        return
    fi

    echo -e "${C}[*] FETCHING LATEST VERSION...${RS}"
    git fetch origin 2>/dev/null

    local BRANCH=$(git branch --show-current)
    [ -z "$BRANCH" ] && BRANCH="main"

    local LOCAL=$(git rev-parse HEAD 2>/dev/null)
    local REMOTE=$(git rev-parse "origin/$BRANCH" 2>/dev/null)

    if [ "$LOCAL" = "$REMOTE" ]; then
        echo -e "${G}[√] ALREADY LATEST VERSION!${RS}"
        echo -e "${Y}  ➤ NO UPDATE NEEDED.${RS}"
        sleep 2
        menu
        return
    fi

    echo -e "${Y}[*] NEW VERSION FOUND. DOWNLOADING...${RS}"
    git pull origin "$BRANCH" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${G}[√] UPDATE COMPLETED SUCCESSFULLY!${RS}"
        echo -e "${Y}  ➤ RESTARTING SCRIPT...${RS}"
        sleep 2
        exec bash "$REPO_DIR/install.sh"
    else
        echo -e "${R}[!] UPDATE FAILED.${RS}"
        sleep 2
        menu
    fi
}

# ───────────────────────────────────────────────────────────
#  MAIN MENU
# ───────────────────────────────────────────────────────────
menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} NECESSARY SETUP"
    printf "\n${left_pad}${C}[${W}02${C}]${G} SETUP YOUR NAME"
    printf "\n${left_pad}${C}[${W}03${C}]${B} SETUP AI"
    printf "\n${left_pad}${C}[${W}04${C}]${W} AUTO UPDATE N-THEME"
    printf "\n${left_pad}${C}[${W}00${C}]${R} EXIT TERMINAL\n\n"

    echo -ne "${left_pad}${C}SELECTION: ${RS}"
    read a
    case $a in
        1|01) do_full_setup ;;
        2|02) do_bash_quick_setup ;;
        3|03) do_font_auto_setup ;;
        4|04) do_update ;;
        0|00) exit ;;
        *) menu ;;
    esac
}

# START
menu
