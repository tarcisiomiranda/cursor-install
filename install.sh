installCursor() {
  if ! [ -f /home/tarcisio/.local/bin/cursor.appimage ]; then
    echo "Installing Cursor AI IDE..."
    APPIMAGE_PATH="/home/tarcisio/.local/bin/cursor.appimage"
    ICON_PATH="/home/tarcisio/.local/bin/cursor.png"
    DESKTOP_ENTRY_PATH="/home/tarcisio/.local/share/applications/cursor.desktop"

    echo "Copy Cursor AppImage..."
    sudo cp Cursor-0.48.7-x86_64.AppImage $APPIMAGE_PATH
    sudo chmod +x $APPIMAGE_PATH

    echo "Downloading Cursor icon..."
    sudo cp icon.png $ICON_PATH

    echo "Creating .desktop entry for Cursor..."
    sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
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
