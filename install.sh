#!/usr/bin/env bash

installCursor() {
  if ! [ -f "$HOME/.local/bin/cursor.appimage" ]; then
    echo "Installing Cursor AI IDE..."
    RAW_ICON="cursor.png"
    APPIMAGE_PATH="$HOME/.local/bin/cursor.appimage"
    ICON_PATH="$HOME/.local/bin/cursor.png"
    DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/Cursor.desktop"

    echo "Downloading Cursor AppImage..."
    curl -L -o "$APPIMAGE_PATH" "https://downloads.cursor.com/production/1d623c4cc1d3bb6e0fe4f1d5434b47b958b05876/linux/x64/Cursor-0.48.7-x86_64.AppImage"
    chmod +x "$APPIMAGE_PATH"

    echo "Copying icon..."
    cp "$RAW_ICON" "$ICON_PATH"

    echo "Creating .desktop entry for Cursor..."
    cat > "$DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=Code Cursor
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

removeCursor() {
  APPIMAGE_PATH="$HOME/.local/bin/cursor.appimage"
  ICON_PATH="$HOME/.local/bin/cursor.png"
  DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/Cursor.desktop"

  echo "Removing old installation files..."
  if [ -f "$APPIMAGE_PATH" ] || [ -f "$ICON_PATH" ] || [ -f "$DESKTOP_ENTRY_PATH" ]; then
    rm -f "$APPIMAGE_PATH" "$ICON_PATH" "$DESKTOP_ENTRY_PATH"
    echo "Files removed successfully."
  else
    echo "No installation files found to remove."
  fi
}

echo "Choose an option:"
echo "1) Install/Update Cursor AI IDE"
echo "2) Remove current installation"
read -rp "Option: " option

case $option in
  1)
    installCursor
    ;;
  2)
    removeCursor
    ;;
  *)
    echo "Invalid option."
    ;;
esac
