CONFIG_DIR="$HOME/.config"
ln -s "$(pwd)/nvim_config" "$CONFIG_DIR/nvim"
echo "Linked: ./nvim_config => $CONFIG_DIR/nvim"
