{pkgs, ...}:{
  home.packages = with pkgs; [
    kitty bemenu tmux 
    firefox tmux  wget vim ffmpeg wl-clipboard
    wf-recorder
    gnome3.adwaita-icon-theme
    mpv grim slurp
    qemu
    gruvbox-dark-gtk
    gruvbox-dark-icons-gtk
    unrar unzip
    transmission-gtk
    easyeffects pulsemixer
    openjdk 
    nodejs
    git 
    st
    gamemode
    freeciv
    openttd xonotic
    drawterm plan9port libreoffice
    gimp yt-dlp zathura
    nsxiv
    mypaint
    virt-manager
    wineWowPackages.waylandFull
    (callPackage ./modules/gamescope.nix {})
    winetricks
    waypipe
    polymc
    pciutils
    godot
    looking-glass-client
  ];
}
