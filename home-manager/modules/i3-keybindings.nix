{ pkgs, config, mod, workspaces }:

{
  "${mod}+Shift+e" = "exec [ \"$(printf \"No\\nYes\" | ${pkgs.dmenu}/bin/dmenu -i -p \"Would you like to exit i3?\")\" = \"Yes\" ] && ${pkgs.i3-gaps}/bin/i3-msg exit";
  "${mod}+Shift+r" = "exec i3-msg restart";

  "${mod}+d" = "exec --no-startup-id ${pkgs.dmenu}/bin/dmenu_run -nf '#222222' -nb '#FFFFFF' -sb '#FFFFFF' -sf '#005599'";

  # General programs
  "${mod}+Return" = "exec --no-startup-id ${pkgs.alacritty}/bin/alacritty";
  "--release ${mod}+Shift+c" = "exec ${pkgs.xcolor}/bin/xcolor |xclip -selection clipboard ";
  "${mod}+Shift+s" = "exec --no-startup-id ${pkgs.maim}/bin/maim -Bus | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
  "--release Print" = "exec --no-startup-id ${pkgs.maim}/bin/maim -Bu | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";


  # Navigation
  "${mod}+h" = "focus left";
  "${mod}+l" = "focus right";
  "${mod}+k" = "focus up";
  "${mod}+j" = "focus down";
  "${mod}+Shift+h" = "move left";
  "${mod}+Shift+l" = "move right";
  "${mod}+Shift+k" = "move up";
  "${mod}+Shift+j" = "move down";
  "${mod}+Ctrl+h" = "resize shrink width 10 px or 10 ppt";
  "${mod}+Ctrl+l" = "resize grow width 10 px or 10 ppt";
  "${mod}+Ctrl+k" = "resize shrink height 10 px or 10 ppt";
  "${mod}+Ctrl+j" = "resize grow height 10 px or 10 ppt";
  "${mod}+Shift+Ctrl" = "split h";
  "${mod}+v" = "split v";
  "${mod}+s" = "layout stacking";
  "${mod}+w" = "layout tabbed";
  "${mod}+e" = "layout toggle split";
  "${mod}+f" = "fullscreen toggle";
  "${mod}+Shift+space" = "floating toggle";
  "${mod}+space" = "focus mode_toggle";
  "${mod}+a" = "focus parent";
  "${mod}+Shift+q" = "kill";
  "${mod}+1" = "workspace ${workspaces.ws1}";
  "${mod}+2" = "workspace ${workspaces.ws2}";
  "${mod}+3" = "workspace ${workspaces.ws3}";
  "${mod}+4" = "workspace ${workspaces.ws4}";
  "${mod}+5" = "workspace ${workspaces.ws5}";
  "${mod}+Shift+1" = "move container to workspace ${workspaces.ws1}";
  "${mod}+Shift+2" = "move container to workspace ${workspaces.ws2}";
  "${mod}+Shift+3" = "move container to workspace ${workspaces.ws3}";
  "${mod}+Shift+4" = "move container to workspace ${workspaces.ws4}";
  "${mod}+Shift+5" = "move container to workspace ${workspaces.ws5}";

}
