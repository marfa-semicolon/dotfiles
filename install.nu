#!/bin/nu

(sudo pacman -Syu --needed
    # initial installation
    curl wget desktop-file-utils base-devel figlet
    # install git
    git git-delta
    # install npm
    npm
    unzip
    # install bun
    bun
    # install browser
    firefox-developer-edition
    # install helix
    helix
    # install syncthing
    syncthing
    # install clipboard manager
    wl-clipboard
    # install docker
    docker docker-buildx docker-compose
    # install terminal
    kitty
    picom
    # install starship
    starship
    # install zoxide
    zoxide
    # install bat
    bat
    # install ripgrep
    ripgrep
    # install dunst
    dunst
    # install VPN
    openvpn wireguard-tools systemd-resolvconf proton-vpn-gtk-app
    # install font
    ttf-jetbrains-mono-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji otf-font-awesome
    # install IME program
    fcitx5-im fcitx5-anthy fcitx5-configtool wev
    # install Qt & GTK config tool
    qt5ct qt6ct nwg-look
    # install file manager
    yazi nemo fzf gvfs glib2 gvfs-mtp gvfs-afc gvfs-gphoto2 gvfs-nfs gvfs-smb gvfs-dnssd gvfs-goa gvfs-onedrive gvfs-wsdd xdg-user-dirs
    # install screen capture program
    grim wf-recorder slurp
    # install fastfetch
    fastfetch imagemagick
    # install system monitor
    btop bottom systemctl-tui
    # install document utils
    okular libreoffice-still readest
    # install multimedia utils
    eog mpv gthumb
    # install audio utils
    pipewire pipewire-pulse wireplumber pavucontrol termusic easyeffects
    # install network utils
    networkmanager
    # install sway utils
    sway swaybg swayidle rofi-wayland rofi-calc waybar inotify-tools
    # install hyprland utils
    xdg-desktop-portal-hyprland hyprpolkitagent qt5-wayland qt6-wayland hyprland hyprshot hypridle hyprlock hyprpaper hyprshutdown hyprsunset
    # install manual pages
    man-db man-pages tldr
    # install LSP and formatter
    yamlfmt shfmt taplo-cli ty jedi-language-server python-lsp-server
    # install superproductivity
    superproductivity
)

# npm config
npm config set prefix ~/.npm-global

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

(yay -Syu --needed
    # install tablet driver
    opentabletdriver
    # install pacman-static
    pacman-static
    # install browser
    zen-browser-bin
    brave-bin
    helium-browser-bin
    # install anki
    anki-bin
    # install appimagelauncher
    appimagelauncher
    # install sway utils
    swaylock-effects
    light
    # install LSP & formatter
    lemminx
    zprint-bin
    # install OCR program
    quicksnip-git
    # install document utils
    onlyoffice-bin
    logseq-desktop-bin
    # install file manager
    simple-mtpfs   
)

(bun install -g
    vscode-langservers-extracted
    dockerfile-language-server-nodejs
    "@microsoft/compose-language-service"
    "@tailwindcss/language-server"
    bash-language-server
    typescript
    typescript-language-server
    "@vue/language-server"
    prettier
    sql-language-server
)

# install rustup
^curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | ^sh

# install rust-analyzer
^rustup component add rust-analyzer

(^cargo install
    emmylua_ls
    emmylua_check
    emmylua_doc_cli
)

# enable and run systemd user services
(^systemctl enable --now --user
    syncthing.service
    pipewire.service
    pipewire-pulse.service
    wireplumber.service
)

# enable and run systemd system services
(^systemctl enable --now
    dockerd.socket
    NetworkManager.service
)

# Hide window button from GTK window
dconf write /org/gnome/desktop/wm/preferences/button-layout "':'"

# user and shell configuration
sudo usermod -aG video "$USER"
sudo chsh -s /usr/bin/nu "$USER"

# others
xdg-user-dirs-update
light -N 5
zoxide init nushell | save -f ~/.zoxide.nu
ya pkg add boydaihungst/gvfs

