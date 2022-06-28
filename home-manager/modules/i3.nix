{ pkgs, config, ... }: 

let 
  mod = "Mod4";

  workspaces = {
    ws1 = "[term]";
    ws2 = "[social]";
    ws3 = "[www]";
    ws4 = "[gaems]";
    ws5 = "[w/e]";
  };

  # Colors
  backgroundColor = "#ffffff";
  textColor = "#222222";
  inactiveTextColor = "#555555";
in {

  xsession = {
    pointerCursor = {
      package = pkgs.vanilla-dmz;
      defaultCursor = "X_cursor";
      name = "Vanilla-DMZ";
    };
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3;

      config = {
        modifier = mod;
        keybindings = import ./i3-keybindings.nix { inherit config pkgs mod workspaces; };
        fonts = {
          names = [ "Liberation Sans" ];
          size = 10.0;
        };
        defaultWorkspace = "workspace ${workspaces.ws1}";

        # Disable default resize mode
        modes = {};

        #terminal = "{pkgs.alacritty}/bin/alacritty";

        window.commands = [
          { command = "border pixel 0"; criteria.class = "^.*"; }
        ];

        startup = [
        ];

        assigns = {
        };

        colors = {
          focused = { background = "#81848c"; border = "#81848c"; childBorder = "#81848c"; text = textColor; indicator = "#81848c"; };
          focusedInactive = { background = backgroundColor; border = backgroundColor; childBorder = backgroundColor; text = inactiveTextColor; indicator = backgroundColor; };
          unfocused = { background = backgroundColor; border = backgroundColor; childBorder = backgroundColor; text = inactiveTextColor; indicator = backgroundColor; };
          urgent = { background = "#e53935"; border = "e53935"; childBorder = "e53935"; text = textColor; indicator = backgroundColor; };
        };
      };
    };
  }; 
}
