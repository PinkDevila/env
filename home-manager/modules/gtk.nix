{config, pkgs, ...}:{
  gtk = {
    enable = true;
    theme = {
      package = pkgs.numix-solarized-gtk-theme;
      #package = pkgs.whitesur-gtk-theme;
      name = "NumixSolarizedLightRed";
  };
  iconTheme = {
    package = pkgs.gruvbox-dark-icons-gtk;
    name = "oomox-gruvbox-dark";
  };
};
}
