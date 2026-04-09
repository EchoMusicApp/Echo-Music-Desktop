<div align="center">
  <img src="assets/Echo_github.png" alt="Echo Music Logo" width="140"/>

  <h1>Echo Music Desktop</h1>

  <p><strong>A robust, open-source music streaming client for Desktop</strong></p>
  <p>Ad-free experience, offline capabilities, and advanced music discovery.</p>

  <br/>

  <a href="https://github.com/EchoMusicApp/Echo-Music-Desktop/releases/download/v1.0/EchoMusic.exe">
    <img src="assets/Windows-button.png" alt="Download for Windows" width="170"/>
  </a>
  &nbsp;
  <a href="https://github.com/EchoMusicApp/Echo-Music-Desktop/releases/download/v1.0/EchoMusic.dmg">
    <img src="assets/mac-button.png" alt="Download for Mac" width="170"/>
  </a>
</div>

---

## Overview

Echo Music Desktop brings the premium listening experience to your computer. Built with Flutter, it streams from YouTube Music without advertisements and adds powerful desktop-centric features across Windows, macOS, and Linux.

---

## Screenshots

<div align="center">
  <img src="Screenshots/Desktop-1.png" alt="Desktop Home" width="400"/>
  <img src="Screenshots/Desktop-2.png" alt="Desktop Player" width="400"/>
  <img src="Screenshots/Desktop-3.png" alt="Desktop Library" width="400"/>
  <img src="Screenshots/Desktop-4.png" alt="Desktop Settings" width="400"/>
</div>

---

## Features

- **Ad-Free Streaming** — Uninterrupted music playback.
- **High Quality Audio** — Stream in the best available quality.
- **Offline Mode** — Download tracks and playlists for offline listening.
- **Synchronized Lyrics** — Real-time synced lyrics with AI-powered multilingual translation.
- **Cross-Platform** — Supports Windows, macOS, and Linux.
- **Smart Recommendations** — Personalized suggestions based on your listening history.
- **Sleep Timer** — Set automatic playback stop after a chosen duration.

---

## Installation

### Windows
1. Download the latest `.exe` installer from the [Releases Page](https://github.com/iad1tya/Echo-Music/releases/latest).
2. Run the installer and follow the on-screen prompts.

### macOS
1. Download the `.dmg` file from the [Releases Page](https://github.com/iad1tya/Echo-Music/releases/latest).
2. Open the disk image and drag Echo Music to your Applications folder.
3. If you see a security warning, go to **System Settings → Privacy & Security** and allow the app.

### Linux
Echo Music is available as an AppImage, DEB, and RPM package.

1. Download the appropriate package from the [Releases Page](https://github.com/iad1tya/Echo-Music/releases/latest).
2. **AppImage** — Make it executable and run it:
   ```bash
   chmod +x Echo-Music-*.AppImage && ./Echo-Music-*.AppImage
   ```
3. **DEB/RPM** — Install via your package manager:
   ```bash
   sudo dpkg -i package.deb
   # or
   sudo rpm -i package.rpm
   ```

---

## Build from Source

Ensure Flutter is installed and configured for desktop development.

1. **Clone the repository**
   ```bash
   git clone https://github.com/iad1tya/Echo-Music.git
   cd Echo-Music
   ```

2. **Enable desktop support**
   ```bash
   flutter config --enable-windows-desktop
   flutter config --enable-macos-desktop
   flutter config --enable-linux-desktop
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   ```

4. **Run the app**
   ```bash
   flutter run -d [windows|macos|linux]
   ```

5. **Build for release**
   ```bash
   flutter build [windows|macos|linux]
   ```

---

## Community & Support

Join the community for updates, discussions, and help.

<div align="center">
  <a href="https://discord.gg/EcfV3AxH5c"><img src="assets/discord.png" width="140"/></a>
  &nbsp;
  <a href="https://t.me/EchoMusicApp"><img src="assets/telegram.png" width="130"/></a>
</div>

---

## Support the Project

If Echo Music Desktop has been useful to you, consider supporting its development.

<div align="center">
  <a href="https://buymeacoffee.com/iad1tya"><img src="assets/bmac.png" width="140"/></a>
  &nbsp;
  <a href="https://intradeus.github.io/http-protocol-redirector/?r=upi://pay?pa=iad1tya@upi&pn=Aditya%20Yadav&am=&tn=Thank%20You"><img src="assets/upi.svg" width="100"/></a>
  &nbsp;
  <a href="https://www.patreon.com/cw/iad1tya"><img src="assets/patreon3.png" width="100"/></a>
</div>

### Cryptocurrency

| Network | Address |
|---------|---------|
| **Bitcoin** | `bc1qcvyr7eekha8uytmffcvgzf4h7xy7shqzke35fy` |
| **Ethereum** | `0x51bc91022E2dCef9974D5db2A0e22d57B360e700` |
| **Solana** | `9wjca3EQnEiqzqgy7N5iqS1JGXJiknMQv6zHgL96t94S` |

---

## Special Thanks

Echo Music Desktop is built with inspiration and help from these excellent open-source projects:

| Project | Description |
|---------|-------------|
| [Gyawun Music](https://github.com/sheikhhaziq/gyawun_music) | Desktop architecture and UI reference |

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=EchoMusicApp/Echo-Music-Desktop&type=timeline&logscale&legend=top-left)](https://www.star-history.com/#EchoMusicApp/Echo-Music-Desktop&type=timeline&logscale&legend=top-left)

---

<div align="center">
  Licensed under <a href="LICENSE">GPL-3.0</a>
</div>
