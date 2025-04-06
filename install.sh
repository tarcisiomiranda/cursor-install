installCursor() {
  if ! [ -f "$HOME/.local/bin/cursor.appimage" ]; then
    echo "Installing Cursor AI IDE..."
    APPIMAGE_PATH="$HOME/.local/bin/cursor.appimage"
    ICON_PATH="$HOME/.local/bin/cursor.png"
    DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/cursor.desktop"

    echo "Downloading Cursor AppImage..."
    curl -L -o "$APPIMAGE_PATH" "https://downloads.cursor.com/production/1d623c4cc1d3bb6e0fe4f1d5434b47b958b05876/linux/arm64/Cursor-0.48.7-aarch64.AppImage"
    chmod +x "$APPIMAGE_PATH"

    echo "Downloading Cursor icon..."
    cp icon.png "$ICON_PATH"

    echo "Creating .desktop entry for Cursor..."
    cat > "$DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=Cursor AI
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;
EOL

    echo "Cursor AI IDE installation complete. You can find it in your application menu."
  else
    echo "Cursor AI IDE is already installed."
  fi
}

installCursor
