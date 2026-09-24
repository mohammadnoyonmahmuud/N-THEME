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

draw_line() {
    printf "${C}${left_pad}%s" "$1"
    for ((i=0; i<BOX_WIDTH-2; i++)); do printf "═"; done
    printf "%s${RS}\n" "$2"
}

print_center() {
    local text="$1"
    local color="$2"
    local len=${#text}
    local space_len=$(( (BOX_WIDTH - 2 - len) / 2 ))
    printf "${C}${left_pad}║%*s${color}%s${C}%*s║${RS}\n" $space_len "" "$text" $(( BOX_WIDTH - 2 - len - space_len )) ""
}

banner() {
    clear
    local G="\e[1;32m"
    local C="\e[1;36m"
    local W="\e[1;37m"
    local Y="\e[1;33m"
    local N="\e[0m"

    echo -e "${G}  ███╗   ██╗      ████████╗██╗  ██╗███████╗███╗   ███╗███████╗${N}"
    echo -e "${G}  ████╗  ██║      ╚══██╔══╝██║  ██║██╔════╝████╗ ████║██╔════╝${N}"
    echo -e "${C}  ██╔██╗ ██║         ██║   ███████║█████╗  ██╔████╔██║█████╗  ${N}"
    echo -e "${C}  ██║╚██╗██║         ██║   ██╔══██║██╔══╝  ██║╚██╔╝██║██╔══╝  ${N}"
    echo -e "${Y}  ██║ ╚████║         ██║   ██║  ██║███████╗██║ ╚═╝ ██║███████╗${N}"
    echo -e "${Y}  ╚═╝  ╚═══╝         ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝${N}"
    echo -e ""
    echo -e "${W}        --[ ${G}PREMIUM TERMUX BANNER & THEME CHANGER ${W}]--${N}"
    echo -e ""
    echo -e "${G}  ==============================================${N}"
    echo -e ""
}

ensure_dependencies() {
    echo -e "${Y}[*] Checking dependencies...${RS}"
    local missing=()
    for pkg in git figlet curl wget unzip xz-utils; do
        if ! command -v "$pkg" &>/dev/null; then
            missing+=("$pkg")
        fi
    done
    if [ ${#missing[@]} -ne 0 ]; then
        echo -e "${Y}[*] Installing: ${missing[*]}...${RS}"
        pkg update -y && pkg install "${missing[@]}" -y
    fi
}

# ───────────────────────────────────────────────────────────
#  OPTION 01 — NECESSARY SETUP
# ───────────────────────────────────────────────────────────
do_full_setup() {
    banner
    echo -e "${Y}[*] Running Necessary Setup...${RS}"
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
    echo -e "${G}[√] Necessary Setup completed!${RS}"
    sleep 2
    menu
}

# ───────────────────────────────────────────────────────────
#  OPTION 02 — BASH CUSTOMIZER (Auto — only asks name)
# ───────────────────────────────────────────────────────────
do_bash_quick_setup() {
    banner
    echo -e "${C}  ───[${W} Bash Customizer ${C}]───${RS}"
    echo ""
    echo -e "${G}  [✓] FIGlet Font     : ASCII-Shadow"
    echo -e "${G}  [✓] Banner Color    : Lolcat (Rainbow)"
    echo -e "${G}  [✓] Prompt Symbol   : \$"
    echo -e "${G}  [✓] Prompt Layout   : Git-Aware"
    echo ""
    echo -ne "${Y}  [?]${W} Enter Your Name (Default: NOYON): ${RS}"
    read -r username
    [ -z "$username" ] && username="NOYON"

    ensure_dependencies

    # ble.sh ইনস্টল
    if [ ! -d ~/.local/share/blesh ]; then
        echo -e "${Y}[*] Installing ble.sh (auto-suggestion)...${RS}"
        mkdir -p /tmp
        curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz -o /tmp/ble-nightly.tar.xz 2>/dev/null
        if [ -f /tmp/ble-nightly.tar.xz ]; then
            tar -xJf /tmp/ble-nightly.tar.xz -C "$HOME/.termux/"
            mkdir -p ~/.local/share/blesh
            cp -a "$HOME/.termux/ble-nightly/"* ~/.local/share/blesh/
            rm -rf "$HOME/.termux/ble-nightly" /tmp/ble-nightly.tar.xz
        fi
    fi

    # lolcat (Rainbow ব্যানারের জন্য)
    if ! command -v lolcat &>/dev/null; then
        pkg install ruby -y >/dev/null 2>&1
        gem install lolcat >/dev/null 2>&1 || true
    fi

    # Auto values
    local banner_text="$username"
    local fig_font="ASCII-Shadow"
    local color_style="lolcat"
    local prompt_sym="\$"
    local prompt_layout="git-aware"

    apply_shell_customizations "bash" "$banner_text" "$username" "$fig_font" "$color_style" "$prompt_sym" "$prompt_layout"
}

# ───────────────────────────────────────────────────────────
#  APPLY CUSTOMIZATIONS
# ───────────────────────────────────────────────────────────
apply_shell_customizations() {
    local shell=$1
    local banner_text=$2
    local username=$3
    local fig_font=$4
    local color_style=$5
    local prompt_sym=$6
    local prompt_layout=$7

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

    # Banner Script
    local banner_script="$HOME/.n-theme-banner.sh"
    cat << 'EOF' > "$banner_script"
#!/bin/bash
clear
echo -e '\033[1;32m[*] BOOTING N-THEME...'
echo -ne '\033[1;36m[LOADING MODULES] \033[1;32m'
for i in {1..25}; do echo -ne '█'; sleep 0.01; done
echo -e '\033[0m'
sleep 0.2
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
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null | lolcat 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
    elif [ "$color_style" = "matrix" ]; then
        echo "echo -e '\\033[1;32m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    elif [ "$color_style" = "cyber" ]; then
        echo "echo -e '\\033[1;36m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    else
        echo "echo -e '\\033[1;37m'" >> "$banner_script"
        echo "figlet -d \"\$FIGLET_DIR\" -c -f '$fig_font' -w \$BOX_WIDTH '$banner_text' 2>/dev/null || printf '  $banner_text\\n'" >> "$banner_script"
        echo "echo -e '\\033[0m'" >> "$banner_script"
    fi

    cat << EOF >> "$banner_script"
print_center ''
print_center 'SYSTEM: ONLINE  |  USER: $username'
print_center 'N-THEME ACTIVE'
print_center ''
draw_line '╚' '╝'
EOF

    chmod +x "$banner_script"

    # ─── Bash Setup ───
    if [ "$shell" = "bash" ]; then
        [ -f ~/.bashrc ] && cp ~/.bashrc ~/.bashrc.bak

        cat << 'EOF' > ~/.bashrc
[[ ${USER-} ]] || export USER=$(id -un)
export LANG=en_US.UTF-8
export LC_CTYPE=POSIX

# ble.sh (auto-suggestion)
[[ -f ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh

# Banner
bash ~/.n-theme-banner.sh

# Aliases
alias l='ls -la'
alias ll='ls -l'
EOF

        # .blerc with Enter fix
        cat > "$HOME/.blerc" << 'EOF'
# Suppress broken locale warnings
function ble/util/notify-broken-locale {
  return 0
}

# Enter key fix (disable multi-line auto detect)
bleopt edit_magic_multiline=
bleopt edit_magic_multiline=none
bleopt exec_errexit_mark=
EOF

        # Git-aware prompt
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
        git_info=" ${YELLOW}git:(${branch})${RESET}"
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
    echo -e "${G}[√] Setup completed successfully!${RS}"
    echo -e "${Y}  ➤ Close and reopen Termux to see changes.${RS}"
    echo ""
    echo -ne "${Y}  Press Enter to continue...${RS}"
    read -r
    menu
}

# ───────────────────────────────────────────────────────────
#  FONTS
# ───────────────────────────────────────────────────────────
do_install_font() {
    local font_zip=$1
    local font_name=$2

    ensure_dependencies

    local temp_zip="$HOME/.termux/temp_font.zip"
    mkdir -p "$HOME/.termux"

    echo -e "${Y}[*] Downloading ${font_name}...${RS}"
    curl -L "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/${font_zip}" -o "${temp_zip}"
    if [ $? -ne 0 ] || [ ! -f "${temp_zip}" ]; then
        echo -e "${R}[!] Download failed.${RS}"
        sleep 2
        font_menu
        return
    fi

    local extract_dir="$HOME/.termux/temp_extract"
    rm -rf "$extract_dir"
    mkdir -p "$extract_dir"

    unzip -o -q "${temp_zip}" "*.ttf" -d "$extract_dir"

    local font_files=()
    while IFS= read -r line; do
        [ -n "$line" ] && font_files+=("$line")
    done < <(find "$extract_dir" -type f -name "*.ttf" | sort)

    local num_files=${#font_files[@]}
    if [ $num_files -eq 0 ]; then
        echo -e "${R}[!] No ttf files found.${RS}"
        rm -rf "$extract_dir" "$temp_zip"
        sleep 2
        font_menu
        return
    fi

    local chosen_font=""
    if [ $num_files -eq 1 ]; then
        chosen_font="${font_files[0]}"
    else
        banner
        printf "\n${left_pad}${C}───[${W} Select Variant (${font_name}) ${C}]───\n"
        local idx=1
        for f in "${font_files[@]}"; do
            local name=$(basename "$f")
            printf "\n${left_pad}${C}[${W}%02d${C}]${G} %s" $idx "$name"
            idx=$((idx + 1))
        done
        printf "\n\n${left_pad}${C}Selection (Default: 1): ${RS}"
        read variant_sel
        [ -z "$variant_sel" ] && variant_sel=1
        if ! [[ "$variant_sel" =~ ^[0-9]+$ ]] || [ "$variant_sel" -lt 1 ] || [ "$variant_sel" -gt $num_files ]; then
            variant_sel=1
        fi
        chosen_font="${font_files[$((variant_sel - 1))]}"
    fi

    if [ -n "$chosen_font" ] && [ -f "$chosen_font" ]; then
        mv "$chosen_font" "$HOME/.termux/font.ttf"
        rm -rf "$extract_dir" "$temp_zip"
        command -v termux-reload-settings &>/dev/null && termux-reload-settings
        echo -e "${G}[√] ${font_name} installed!${RS}"
    fi
    sleep 2
    font_menu
}

font_menu() {
    banner
    printf "\n${left_pad}${C}───[${W} Termux Nerd Fonts ${C}]───"
    printf "\n${left_pad}${C}[${W}01${C}]${G} Fira Code"
    printf "\n${left_pad}${C}[${W}02${C}]${G} JetBrains Mono"
    printf "\n${left_pad}${C}[${W}03${C}]${G} Hack"
    printf "\n${left_pad}${C}[${W}04${C}]${G} Caskaydia Cove"
    printf "\n${left_pad}${C}[${W}05${C}]${G} Sauce Code Pro"
    printf "\n${left_pad}${C}[${W}06${C}]${G} Ubuntu"
    printf "\n${left_pad}${C}[${W}07${C}]${G} Meslo"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back\n\n"

    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_install_font "FiraCode.zip" "Fira Code" ;;
        2|02) do_install_font "JetBrainsMono.zip" "JetBrains Mono" ;;
        3|03) do_install_font "Hack.zip" "Hack" ;;
        4|04) do_install_font "CascadiaCode.zip" "Caskaydia Cove" ;;
        5|05) do_install_font "SourceCodePro.zip" "Sauce Code Pro" ;;
        6|06) do_install_font "Ubuntu.zip" "Ubuntu" ;;
        7|07) do_install_font "Meslo.zip" "Meslo" ;;
        0|00) menu ;;
        *) font_menu ;;
    esac
}

# ───────────────────────────────────────────────────────────
#  SECURITY & UPDATES
# ───────────────────────────────────────────────────────────
do_add_lock() {
    echo -e "\n${C}Initialising Security Protocol...${RS}"
    echo -ne "${Y}Create Access Key: ${RS}"
    read -s new_pass
    echo
    new_pass_hash=$(echo -n "$new_pass" | sha256sum | cut -d' ' -f1)

    lock_code="#LOCK_START
clear
attempt=1
while [ \$attempt -le 3 ]; do
    echo -e \"\n${C}╔══════════════════════════════════════╗\"
    echo -e \"║        ${R}N-THEME SECURE ACCESS        ${C}║\"
    echo -e \"╚══════════════════════════════════════╝${RS}\"
    echo -ne \"${Y} [Attempt \$attempt/3] Enter Key: ${RS}\"
    read -s pass_input
    echo
    entered_hash=\$(echo -n \"\$pass_input\" | sha256sum | cut -d' ' -f1)
    if [ \"\$entered_hash\" = \"$new_pass_hash\" ]; then
        echo -e \"${G} ACCESS GRANTED.${RS}\"
        sleep 1
        clear
        break
    else
        echo -e \"${R} DENIED.${RS}\"
        [ \$attempt -eq 3 ] && exit
        attempt=\$((attempt + 1))
    fi
done
#LOCK_END"

    if [ -f ~/.bashrc ]; then
        echo "$lock_code" > ~/.bashrc.tmp
        cat ~/.bashrc >> ~/.bashrc.tmp
        mv ~/.bashrc.tmp ~/.bashrc
    fi
    echo -e "${G}Lock Configured.${RS}"
    sleep 2
    system_menu
}

do_remove_lock() {
    sed -i '/#LOCK_START/,/#LOCK_END/d' ~/.bashrc
    echo -e "${R}Lock removed.${RS}"
    sleep 2
    system_menu
}

do_update() {
    banner
    echo -e "${Y}[*] Checking for updates...${RS}"
    git -C "$REPO_DIR" fetch origin
    local LOCAL=$(git -C "$REPO_DIR" rev-parse HEAD)
    local REMOTE=$(git -C "$REPO_DIR" rev-parse "origin/main" 2>/dev/null || git -C "$REPO_DIR" rev-parse "origin/master")
    if [ "$LOCAL" = "$REMOTE" ]; then
        echo -e "${G}[√] Already latest version.${RS}"
        sleep 2
        system_menu
    else
        git -C "$REPO_DIR" pull
        echo -e "${G}[√] Updated! Restarting...${RS}"
        sleep 2
        exec bash "$REPO_DIR/install.sh"
    fi
}

system_menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${B} Add Cyber Lock"
    printf "\n${left_pad}${C}[${W}02${C}]${R} Remove Lock"
    printf "\n${left_pad}${C}[${W}03${C}]${W} Update N-THEME"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Back to Main Menu\n\n"

    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_add_lock ;;
        2|02) do_remove_lock ;;
        3|03) do_update ;;
        0|00) menu ;;
        *) system_menu ;;
    esac
}

# ───────────────────────────────────────────────────────────
#  MAIN MENU
# ───────────────────────────────────────────────────────────
menu() {
    banner
    printf "\n${left_pad}${C}[${W}01${C}]${G} Necessary Setup"
    printf "\n${left_pad}${C}[${W}02${C}]${G} Bash Customizer"
    printf "\n${left_pad}${C}[${W}03${C}]${B} Termux Nerd Fonts"
    printf "\n${left_pad}${C}[${W}04${C}]${W} Security & Updates"
    printf "\n${left_pad}${C}[${W}00${C}]${R} Exit Terminal\n\n"

    echo -ne "${left_pad}${C}Selection: ${RS}"
    read a
    case $a in
        1|01) do_full_setup ;;
        2|02) do_bash_quick_setup ;;
        3|03) font_menu ;;
        4|04) system_menu ;;
        0|00) exit ;;
        *) menu ;;
    esac
}

# START
menu
