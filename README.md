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




## 📦 Requirements

Before installing, make sure you have:

- ✅ **Termux** — latest version from [F-Droid](https://f-droid.org/en/packages/com.termux/) *(avoid Play Store version)*
- ✅ **Android 7.0** or above
- ✅ **Internet connection** (for first-time setup only)
- ✅ **~100 MB** free storage

---


## 🚀 Installation



#### Step 1 — Update packages

```bash
pkg update && pkg upgrade -y
```


#### Step 2 — Install required packages

```bash
pkg install git python -y
```

#### Step 3 — Setup storage access

```bash
termux-setup-storage
```

> 📱 A permission popup will appear — tap **Allow**.

#### Step 4 — Clone this repository

```bash
git clone https://github.com/mohammadnoyonmahmuud/N-THEME.git
```

#### Step 5 — Enter the directory

```bash
cd N-THEME
```

#### Step 6 — Run the installer

```bash
bash install.sh
```

---


#### 1️⃣ Download necessary files

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

#### 2️⃣ Setup Banner

- Prompts you to enter your name
- Automatically converts it to **UPPERCASE** (`noyon` → `NOYON`)
- Saves **permanently** as your animated banner

#### 3️⃣ Setup Name

- Prompts you to enter your name
- Saves as your prompt in this format:

```
TERMUX@NOYON$
```

> 🔒 `TERMUX` is **fixed** — only `NOYON` changes based on your input.

---

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

#### 🛠️ Tech Stack

| Tool | Purpose |
|------|---------|
| **Bash** | Shell scripting |
| **ble.sh** | Auto-suggestion & syntax highlighting |
| **figlet** | ASCII banner generation |
| **Python** | Helper scripts |
| **Git** | Version control |

---

#### 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a **Pull Request**

---

#### 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

#### 👤 Author

<div align="center">

**Mohammad Noyon Mahmud**

[![GitHub](https://img.shields.io/badge/GitHub-mohammadnoyonmahmuud-181717?style=for-the-badge&logo=github)](https://github.com/mohammadnoyonmahmuud)

</div>

---

<div align="center">
