{pkg, config, ...}:{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "bottom";
        #height = 16;
        modules-left = [
          "sway/workspaces" 
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
        ];
      };
    };
    style = ''
      *{
        font-family: 'Fira Code';
        font-size: 12;
        padding: 1px 2px;
        margin: 0;
      }
    '';

  };
}
