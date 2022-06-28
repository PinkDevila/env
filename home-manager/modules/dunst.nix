{ pkgs, config, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        color = "#CDD6F4";
        frame_color = "#1E1E2E";
        separator_color = "#1E1E2E";
        font = "Fira Code 13";
        alignment = "center";
      };
  
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        history = "ctrl+grave";
        context = "ctrl+shift+period";
      };
  
      urgency_low = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 10;
      };
      urgency_critical = {
        background = "#1E1E2E";
        foreground = "#CDD6F4";
        timeout = 10;
      };
    };
 };
}
