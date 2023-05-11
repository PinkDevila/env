{config, pkgs, ...}:{
  programs.waybar = {
    enable = true;
    settings = {
      bar = {
        layer = "top";
        position = "top";

        modules-left = ["sway/workspaces"];
        modules-center = ["clock"];
        modules-right = ["tray"];
      };
    };
    style = ''
      * {
        padding: 0px 0px;
        margin: 0px;
      }

      #workspaces button {
        margin: 0px;
        padding: 0px 4px;
        border-radius: 0px;
      } 
    '';
  };
}
