{ config, pkgs, ... }:
let
  ime = "fcitx5";
in
{
  imports = [
    ./modules/chromium.nix
    ./modules/dunst.nix
    ./modules/firefox.nix
    ./modules/git.nix
    ./modules/gtk.nix
    ./modules/mpv.nix
    ./modules/qt.nix
    ./modules/qutebrowser.nix
    ./modules/scripts.nix
    ./modules/sway.nix
    ./modules/tmux.nix
    ./modules/vim.nix
    ./modules/waybar.nix
    ./packages.nix
  ];
  
  home.username = "sera";
  home.homeDirectory = "/home/sera";
  home.sessionVariables = {
     XDG_CURRENT_DESKTOP = "sway";
      GTK_IM_MODULE       = "${ime}";
      GLFW_IM_MODULE      = "${ime}";
      QT_IM_MODULE        = "${ime}";
      AMD_VULKAN_ICD      = "RADV";
      EDITOR              = "vim";
      QT_STYLE_OVERRIDE   = "gtk2";
      XMODIFIERS          = "@im=${ime}";
      NIXPKGS_ALLOW_UNFREE= 1;
      GOPATH              = "$HOME/Source/go";
      MEDNAFEN_HOME       = "$HOME/.config/mednafen";
    };
  home.stateVersion = "22.05";

  programs.home-manager.enable = true;
}
