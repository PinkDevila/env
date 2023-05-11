{pkgs, config, ...}:
let
  workspaces = {
    ws1 = "1";
    ws2 = "2";
    ws3 = "3";
    ws4 = "4";
    ws5 = "5";
    ws6 = "6";
    ws7 = "7";
    ws8 = "8";
    ws9 = "9";
    ws10 = "10";
  };
  mod = "Mod4";
  alt = "Mod4";
  terminal = "${pkgs.st}/bin/st";
  menu = "menu";
in{
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    wrapperFeatures.gtk = true ;
    config = {
      modifier = "${mod}";
      fonts = {
        names = ["monospace"];
        style = "";
        size = 12.0;
      };
      bars = [];
      defaultWorkspace = "worspace number 1";
      window = {
        border = 0;
      };
      colors = {
        focused = {
          background = "#FFFFFF";
          border = "#FFFFFF";
          childBorder = "#FFFFFF";
          indicator = "#FF0000";
          text = "#222222";
        };
        unfocused = {
          background = "#222222";
          border = "#222222";
          childBorder = "#222222";
          indicator = "#FF0000";
          text = "#FFFFFF";
        };
      };
      output = {
        "*" = {
          bg = "~/.config/wall.png fill";
          scale = "1.0";
        };
      };
      input = { 
        "*" = { 
          repeat_delay="150";
          natural_scroll = "enabled";
          repeat_rate = "60";
          xkb_layout = "us,us(colemak)";
          #accel_profile = "flat";
          xkb_options = "ctrl:nocaps";
        };
      };
      keybindings = {
        #general apps
        "${alt}+s" = "exec screenshot";
        "Print" = "exec ${pkgs.grim}/bin/grim -| ${pkgs.wl-clipboard}/bin/wl-copy -t image/png";
        "${alt}+Shift+s" = "exec record";
        "${alt}+Return" = "exec ${terminal}";
        "${alt}+x" = "exec ${menu}";

        #window management
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus right";
        "${mod}+l" = "focus up";
        "${mod}+h" = "focus down";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+j" = "move down";

        #workspace shit
        "${mod}+1" = "workspace ${workspaces.ws1}";
        "${mod}+2" = "workspace ${workspaces.ws2}";
        "${mod}+3" = "workspace ${workspaces.ws3}";
        "${mod}+4" = "workspace ${workspaces.ws4}";
        "${mod}+5" = "workspace ${workspaces.ws5}";
        "${mod}+6" = "workspace ${workspaces.ws6}";
        "${mod}+7" = "workspace ${workspaces.ws7}";
        "${mod}+8" = "workspace ${workspaces.ws8}";
        "${mod}+9" = "workspace ${workspaces.ws9}";
        "${mod}+0" = "workspace ${workspaces.ws10}";
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
        "${mod}+f" = "fullscreen toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+Shift+c" = "kill";

        "${mod}+b" = "exec pkill -SIGUSR1 waybar";

        "${mod}+t" = "layout tabbed";
        "${alt}+p" = "exec dunstify \"$(date \"+%T\")\"";

      };
      startup = [
        { command = "exec systemctl --user import-environment";}
        { command = "exec fcitx5 -d";}
        { command = "exec waybar";}
        { command = "exec swaymsg workspace 1";}
        { command = "exec ${pkgs.swayidle}/bin/swayidle -w timeout 300 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"'";}
      ];
    };
    extraConfig = ''
      titlebar_border_thickness 0                                                     
      titlebar_padding 0
    '';
  };
}
