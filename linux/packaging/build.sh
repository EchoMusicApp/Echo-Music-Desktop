#!/usr/bin/env bash
# Build Linux packages locally: AppImage, .deb, .rpm
# Run from repo root: ./linux/packaging/build.sh
# Requires: flutter, patchelf. Optional: appimagetool (or downloaded), fpm and/or dpkg for packages.

set -e
cd "$(dirname "$0")/../.."
REPO_ROOT="$PWD"

if ! command -v patchelf &>/dev/null; then
  echo "patchelf is required. Install it:"
  echo "  Fedora: sudo dnf install patchelf"
  echo "  Debian/Ubuntu: sudo apt install patchelf"
  exit 1
fi

# Optional: skip Flutter build and use existing bundle (e.g. after "flutter build linux")
SKIP_FLUTTER_BUILD=false
[ "${1:-}" = "--no-flutter-build" ] || [ "${1:-}" = "-n" ] && SKIP_FLUTTER_BUILD=true

# Version from pubspec.yaml
VERSION=$(grep '^version:' pubspec.yaml | sed 's/version: *//;s/+.*//;s/ *$//')
echo "Building Echo Music $VERSION"

BUNDLE="$REPO_ROOT/build/linux/x64/release/bundle"
if [ "$SKIP_FLUTTER_BUILD" = true ]; then
  if [ ! -x "$BUNDLE/echo" ]; then
    echo "Bundle not found. Run: flutter build linux"
    exit 1
  fi
  echo "Using existing bundle (skip Flutter build)"
else
  flutter pub get
  flutter build linux --release
fi
# Flutter Linux engine looks for lib/ and data/ in the executable's directory
# (executable_dir/lib/libapp.so, executable_dir/data/flutter_assets). So we put
# lib and data under usr/bin/ for both AppImage and .deb/.rpm.
STAGING="$REPO_ROOT/build/linux_pkg_staging"
rm -rf "$STAGING"
mkdir -p "$STAGING/usr/bin/lib" "$STAGING/usr/bin/data"

# --- Staging: binary, libs, data (all under usr/bin so engine finds them) ---
cp "$BUNDLE/echo-music" "$STAGING/usr/bin/echo-music"
cp -a "$BUNDLE/lib/"* "$STAGING/usr/bin/lib/" 2>/dev/null || true
cp -a "$BUNDLE/data/"* "$STAGING/usr/bin/data/"

# Bundle libmpv and libmimalloc (so users don't need to install them)
ARCH=$(uname -m)
for lib in libmpv libmimalloc; do
  for dir in /usr/lib64 /usr/lib/$ARCH-linux-gnu /usr/lib; do
    for f in "$dir"/$lib.so*; do
      [ -e "$f" ] && cp -P "$f" "$STAGING/usr/bin/lib/" && break 2
    done
  done
done

patchelf --set-rpath '$ORIGIN/lib' "$STAGING/usr/bin/echo-music"
chmod +x "$STAGING/usr/bin/echo-music"

# .deb/.rpm: same layout
PKG_STAGING="$REPO_ROOT/build/linux_pkg_staging_named"
rm -rf "$PKG_STAGING"
mkdir -p "$PKG_STAGING/usr/bin/lib" "$PKG_STAGING/usr/bin/data" \
  "$PKG_STAGING/usr/share/applications" "$PKG_STAGING/usr/share/icons/hicolor/256x256/apps"
cp -a "$STAGING/usr/bin/lib/"* "$PKG_STAGING/usr/bin/lib/"
cp -a "$STAGING/usr/bin/data/"* "$PKG_STAGING/usr/bin/data/"
cp "$REPO_ROOT/icons/Echo_nobg.png" "$PKG_STAGING/usr/share/icons/hicolor/256x256/apps/echo-music.png"
cp "$REPO_ROOT/linux/packaging/echo-music.desktop" "$PKG_STAGING/usr/share/applications/echo-music.desktop"
patchelf --set-rpath '$ORIGIN/lib' "$PKG_STAGING/usr/bin/echo-music"
chmod +x "$PKG_STAGING/usr/bin/echo-music"

echo "Staging ready at $STAGING"

# --- AppImage ---
APPDIR="$REPO_ROOT/build/Echo-Music.AppDir"
rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr" "$APPDIR/usr/share/icons/hicolor/256x256/apps"
cp -a "$STAGING/usr/bin" "$APPDIR/usr/"
cp "$REPO_ROOT/icons/Echo_nobg.png" "$APPDIR/usr/share/icons/hicolor/256x256/apps/echo-music.png"
cp "$REPO_ROOT/icons/Echo_nobg.png" "$APPDIR/echo-music.png"
cp "$REPO_ROOT/linux/packaging/echo-music.desktop" "$APPDIR/echo-music.desktop"
cp "$REPO_ROOT/linux/packaging/AppRun" "$APPDIR/AppRun"
chmod +x "$APPDIR/AppRun"

APPIMAGETOOL=""
if command -v appimagetool &>/dev/null; then
  APPIMAGETOOL=appimagetool
elif [ -x "$REPO_ROOT/build/appimagetool.AppImage" ]; then
  APPIMAGETOOL="$REPO_ROOT/build/appimagetool.AppImage"
else
  echo "Downloading appimagetool..."
  curl -sL -o "$REPO_ROOT/build/appimagetool.AppImage" \
    "https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage"
  chmod +x "$REPO_ROOT/build/appimagetool.AppImage"
  APPIMAGETOOL="$REPO_ROOT/build/appimagetool.AppImage"
fi
ARCH=x86_64 "$APPIMAGETOOL" -n "$APPDIR" "$REPO_ROOT/build/Echo-Music-${VERSION}-x86_64.AppImage"
echo "Built: build/Echo-Music-${VERSION}-x86_64.AppImage"

# --- .deb ---
if command -v dpkg-deb &>/dev/null; then
  PKG="$REPO_ROOT/build/echo-music_${VERSION}_amd64"
  rm -rf "$PKG"
  mkdir -p "$PKG/DEBIAN" "$PKG/usr/share/applications" "$PKG/usr/share/icons/hicolor/256x256/apps"
  cp -a "$PKG_STAGING/usr/bin" "$PKG/usr/"
  cp "$REPO_ROOT/icons/Echo_nobg.png" "$PKG/usr/share/icons/hicolor/256x256/apps/echo-music.png"
  cp "$REPO_ROOT/linux/packaging/echo-music.desktop" "$PKG/usr/share/applications/echo-music.desktop"
  sed "s/VERSION/$VERSION/" "$REPO_ROOT/linux/packaging/control.in" > "$PKG/DEBIAN/control"
  dpkg-deb --root-owner-group --build "$PKG" "$REPO_ROOT/build/echo-music_${VERSION}_amd64.deb"
  rm -rf "$PKG"
  echo "Built: build/echo-music_${VERSION}_amd64.deb"
elif command -v fpm &>/dev/null; then
  fpm -s dir -t deb -n echo-music -v "$VERSION" \
    --architecture amd64 \
    --description "Echo Music Desktop - Music player" \
    -C "$PKG_STAGING" usr
  mv "echo-music_${VERSION}_amd64.deb" "$REPO_ROOT/build/"
  echo "Built: build/echo-music_${VERSION}_amd64.deb"
else
  echo "Skip .deb: install dpkg or fpm (gem install fpm)"
fi

# --- .rpm ---
if command -v fpm &>/dev/null; then
  fpm -s dir -t rpm -n echo-music -v "$VERSION" \
    --architecture x86_64 \
    --description "Echo Music Desktop - Music player" \
    -C "$PKG_STAGING" usr
  mv "$REPO_ROOT/echo-music-${VERSION}-1.x86_64.rpm" "$REPO_ROOT/build/echo-music_${VERSION}_x86_64.rpm"
  echo "Built: build/echo-music_${VERSION}_x86_64.rpm"
else
  echo "Skip .rpm: install fpm (gem install fpm)"
fi

echo "Done. Outputs in build/"
