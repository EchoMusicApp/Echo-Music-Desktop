<div align="center">
  <img src="assets/Echo_github.png" alt="Echo Music Logo" width="140"/>
  <h1>Echo Music Desktop</h1>
  <p><strong>A robust, open-source music streaming client for Desktop</strong></p>
  <p>Ad-free experience, offline capabilities, and advanced music discovery.</p>

  <a href="https://github.com/iad1tya/Echo-Music/releases/latest"><img src="assets/Windows-button.png" alt="Download for Windows" width="170"/></a>
  <a href="https://github.com/iad1tya/Echo-Music/releases/latest"><img src="assets/mac-button.png" alt="Download for Mac" width="170"/></a>
</div>

---

## Overview

Echo Music Desktop brings the premium music listening experience to your computer. Built with Flutter, it offers a seamless interface to stream music from YouTube Music without advertisements, along with powerful desktop-centric features.

## Features

*   **Ad-Free Streaming:** Enjoy uninterrupted music playback.
*   **High Quality Audio:** Stream in the best available quality.
*   **Offline Mode:** Download your favorite tracks and playlists for offline listening.
*   **Lyrics Support:** Real-time synchronized lyrics with AI-powered translation.
*   **Broad Compatibility:** Cross-platform support for Windows, macOS, and Linux.
*   **Smart Recommendations:** Personalized song suggestions based on your listening history.
*   **Sleep Timer:** Configure automatic playback cessation.

## Installation

### Windows
1.  Download the latest installer (`.exe`) from the [Releases Page](https://github.com/iad1tya/Echo-Music/releases/latest).
2.  Run the installer and follow the on-screen prompts.

### macOS
1.  Download the `.dmg` file from the [Releases Page](https://github.com/iad1tya/Echo-Music/releases/latest).
2.  Open the disk image and drag "Echo Music" to your Applications folder.
3.  *Note: If you encounter a security warning, go to System Settings > Privacy & Security and allow the application.*

### Linux
Echo Music is available as an AppImage, DEB, and RPM package.
1.  Download the appropriate package from the [Releases Page](https://github.com/iad1tya/Echo-Music/releases/latest).
2.  **AppImage**: Make it executable (`chmod +x Echo-Music-*.AppImage`) and run it.
3.  **DEB/RPM**: Install using your package manager (e.g., `sudo dpkg -i package.deb`).

## Build from Source

To build Echo Music locally, ensure you have Flutter installed and configured for desktop development.

1.  **Clone the Repository**
    ```bash
    git clone https://github.com/iad1tya/Echo-Music.git
    cd Echo-Music
    ```

2.  **Enable Desktop Support**
    Enable the platforms you intend to build for:
    ```bash
    flutter config --enable-windows-desktop
    flutter config --enable-macos-desktop
    flutter config --enable-linux-desktop
    ```

3.  **Install Dependencies**
    ```bash
    flutter pub get
    ```

4.  **Run the Application**
    ```bash
    flutter run -d [windows|macos|linux]
    ```

5.  **Build for Release**
    ```bash
    flutter build [windows|macos|linux]
    ```

---

## Community and Support

Join our community for updates, support, and discussions.

<div align="center">
  <a href="https://discord.gg/EcfV3AxH5c"><img src="assets/discord.png" width="140"/></a>
  <a href="https://t.me/EchoMusicApp"><img src="assets/telegram.png" width="130"/></a>
</div>

### Support the Project

If you find this project useful, consider supporting its development.

<div align="center">
  <a href="https://buymeacoffee.com/iad1tya"><img src="assets/bmac.png" width="140"/></a>
  <a href="https://intradeus.github.io/http-protocol-redirector/?r=upi://pay?pa=iad1tya@upi&pn=Aditya%20Yadav&am=&tn=Thank%20You"><img src="assets/upi.svg" width="100"/></a>
  <a href="https://www.patreon.com/cw/iad1tya"><img src="assets/patreon3.png" width="100"/></a>
</div>

### Cryptocurrency Addresses
<div align="center">
  <table>
    <tr>
      <td align="center"><strong>Bitcoin</strong><br><img src="assets/Bitcoin.jpeg" width="150"/><br><code>bc1qcvyr7eekha8uytmffcvgzf4h7xy7shqzke35fy</code></td>
      <td align="center"><strong>Ethereum</strong><br><img src="assets/Ethereum.jpeg" width="150"/><br><code>0x51bc91022E2dCef9974D5db2A0e22d57B360e700</code></td>
      <td align="center"><strong>Solana</strong><br><img src="assets/Solana.jpeg" width="150"/><br><code>9wjca3EQnEiqzqgy7N5iqS1JGXJiknMQv6zHgL96t94S</code></td>
    </tr>
  </table>
</div>


---

<div align="center">
    Licensed under <a href="LICENSE">GPL-3.0</a>
</div>
