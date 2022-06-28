{pkgs, config, ...}:
let
    mod = "Mod4";
    alt = "Mod1";
    terminal = "${pkgs.kitty}/bin/kitty";
    menu = "${pkgs.bemenu}/bin/bemenu-run -c -W 0.5 -l 5 -p '' -n";
in{
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true ;
    config = {
      modifier = "Mod4";
      defaultWorkspace = "1";
      fonts = {
        names = ["Fira Code" "Fira Code Retina"];
        style = "";
        size = 0.0;
      };
      window = {
        border = 0;
      };
      bars = [];
      output = {
        "*" = {
          bg = "~/.config/wall.jpg fill";
          scale = "1.0";
        };
      };
      input = { 
        "*" = { 
          repeat_delay="200";
          repeat_rate="60";
        };
      };
      keybindings = {
        #general apps
        "${mod}+Shift+s" = "exec ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" -| ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
        "${mod}+Print" = "exec ${pkgs.grim}/bin/grim -| ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
        "${mod}+Shift+Print" = "exec record";
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+x" = "exec ${menu}";

        #window management
        "${mod}+h" = "focus left";
        "${mod}+l" = "focus right";
        "${mod}+k" = "focus up";
        "${mod}+j" = "focus down";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+j" = "move down";

        #workspace shit
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";

        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+q" = "kill";

        "${mod}+p" = "exec dunstify $(shuf ~/.jp|awk '{print $2}'|head -n1)";

        "${mod}+s" = "layout stacking";
        "${alt}+t" = "exec dunstify \"$(date \"+%T\")\"";

      };
      startup = [
        { command = "exec systemctl --user import-environment";}
        { command = "exec fcitx5 -d";}
        { command = "exec kitty -e tmux";}
      ];
    };
    extraConfig = ''
      titlebar_border_thickness 0                                                     
      titlebar_padding 0
    '';
  };
}
