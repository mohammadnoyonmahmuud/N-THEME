<div align="center">

# 🎨 N-THEME

### A Premium Termux Theme

*Animated Banner • Custom Prompt • Auto-Suggestion • Premium Colors*

[![License: MIT](https://img.shields.io/badge/License-MIT-00C853?style=for-the-badge)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-Termux-1E88E5?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://termux.dev)
[![Shell](https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Made with Love](https://img.shields.io/badge/Made%20with-%E2%9D%A4-FF1744?style=for-the-badge)](https://github.com/mohammadnoyonmahmuud)

**Transform your plain Termux into a beautiful, premium terminal experience.**

[Features](#-features) • [Installation](#-installation) • [Menu](#-menu-options) • [Preview](#-preview) • [FAQ](#-faq)

</div>

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎨 **Premium Colors** | Rich, saturated, eye-soothing palette — no dull or lowlight tones |
| 🖼️ **Animated Banner** | Beautiful ASCII art banner with your name, appears on every Termux launch |
| 💻 **Custom Prompt** | Elegant prompt format: `TERMUX@YOURNAME$` |
| ⌨️ **Auto-Suggestion** | History-based suggestions — type a few letters, get the full command |
| 🔒 **Permanent Setup** | Stays as long as Termux is installed on your device |
| 🧹 **Clean Interface** | Removes default Termux welcome clutter — only your banner & prompt |
| ⚡ **One-Command Install** | Fully automated, step-by-step background installer |

---

## 📦 Requirements

Before installing, make sure you have:

- ✅ **Termux** — latest version from [F-Droid](https://f-droid.org/en/packages/com.termux/) *(avoid Play Store version)*
- ✅ **Android 7.0** or above
- ✅ **Internet connection** (for first-time setup only)
- ✅ **~100 MB** free storage

---

## 🚀 Installation

### Step 1 — Update packages

```bash
pkg update && pkg upgrade -y
```

### Step 2 — Install required packages

```bash
pkg install git python -y
```

### Step 3 — Setup storage access

```bash
termux-setup-storage
```

> 📱 A permission popup will appear — tap **Allow**.

### Step 4 — Clone this repository

```bash
git clone https://github.com/mohammadnoyonmahmuud/N-THEME.git
```

### Step 5 — Enter the directory

```bash
cd N-THEME
```

### Step 6 — Run the installer

```bash
bash install.sh
```

---

## 🎛️ Menu Options

After launching `install.sh`, you'll see a premium menu:

```
╔══════════════════════════════════════╗
║        ✦ N-THEME INSTALLER ✦         ║
╠══════════════════════════════════════╣
║                                      ║
║   [1]  Download necessary files      ║
║   [2]  Setup Banner                  ║
║   [3]  Setup Name                    ║
║                                      ║
╚══════════════════════════════════════╝
```

### 1️⃣ Download necessary files

Runs an **automated step-by-step installer** in the background:

```
▶ [1/8] Updating package list...          ✅
▶ [2/8] Installing dependencies...        ✅
▶ [3/8] Downloading theme files...        ✅
▶ [4/8] Downloading fonts...              ✅
▶ [5/8] Applying colors...                ✅
▶ [6/8] Setting up banner...              ✅
▶ [7/8] Setting up prompt...              ✅
▶ [8/8] Finalizing...                     ✅
```

Each step runs sequentially — one after another, cleanly.

### 2️⃣ Setup Banner

- Prompts you to enter your name
- Automatically converts it to **UPPERCASE** (`noyon` → `NOYON`)
- Saves **permanently** as your animated banner

### 3️⃣ Setup Name

- Prompts you to enter your name
- Saves as your prompt in this format:

```
TERMUX@NOYON$
```

> 🔒 `TERMUX` is **fixed** — only `NOYON` changes based on your input.

---

## 🖼️ Preview

### Banner

```
███╗   ██╗ ██████╗ ██╗   ██╗ ██████╗ ███╗   ██╗
████╗  ██║██╔═══██╗╚██╗ ██╔╝██╔═══██╗████╗  ██║
██╔██╗ ██║██║   ██║ ╚████╔╝ ██║   ██║██╔██╗ ██║
██║╚██╗██║██║   ██║  ╚██╔╝  ██║   ██║██║╚██╗██║
██║ ╚████║╚██████╔╝   ██║   ╚██████╔╝██║ ╚████║
╚═╝  ╚═══╝ ╚═════╝    ╚═╝    ╚═════╝ ╚═╝  ╚═══╝
```

### Prompt

```bash
TERMUX@NOYON$
```

---

## ⌨️ Auto-Suggestion

N-THEME includes **history-based auto-suggestion** powered by `ble.sh`.

### How it works

Say you previously ran:

```bash
noyon -i wlan0 -K
```

Next time, just type the first few letters:

```bash
noy
```

And the suggestion appears below in ghost text:

```bash
noyon -i wlan0 -K
```

Press **`→`** (right arrow) on the Termux keyboard to accept and run.

> ⚡ Saves time. No retyping. Just arrow-key magic.

---

## 🗑️ Uninstall

To completely remove N-THEME:

```bash
cd ~/N-THEME
bash uninstall.sh
```

This will:
- Restore your original `.bashrc` (from backup)
- Remove theme files
- Reset Termux to default state

---

## ❓ FAQ

<details>
<summary><b>Will this survive a phone restart?</b></summary>

Yes ✅ — everything is saved in `.bashrc` and `~/.termux/`, so it persists across restarts, Termux updates, and new sessions.
</details>

<details>
<summary><b>Can I change my name later?</b></summary>

Yes ✅ — just run `bash install.sh` again and choose option 2 or 3.
</details>

<details>
<summary><b>Does it work on root?</b></summary>

Yes ✅ — works on both rooted and non-rooted devices.
</details>

<details>
<summary><b>What if something breaks?</b></summary>

Run `bash uninstall.sh` to restore your backup, then try installing again.
</details>

<details>
<summary><b>Will it slow down my Termux?</b></summary>

No ✅ — `ble.sh` is lightweight and optimized. Startup delay is negligible.
</details>

---

## 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **Bash** | Shell scripting |
| **ble.sh** | Auto-suggestion & syntax highlighting |
| **figlet** | ASCII banner generation |
| **Python** | Helper scripts |
| **Git** | Version control |

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a **Pull Request**

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

## 👤 Author

<div align="center">

**Mohammad Noyon Mahmud**

[![GitHub](https://img.shields.io/badge/GitHub-mohammadnoyonmahmuud-181717?style=for-the-badge&logo=github)](https://github.com/mohammadnoyonmahmuud)

</div>

---

<div align="center">

### ⭐ If you like this project, give it a star!

**Made with ❤️ by Noyon**

</div>
