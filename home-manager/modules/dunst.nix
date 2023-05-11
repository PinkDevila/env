{ pkgs, config, ... }:

{
  services.dunst = {
    enable = true;

    settings = {
      global = {
        color = "#657B83";
        frame_color = "#657B83";
        separator_color = "#657B83";
        font = "monospace 12";
        alignment = "center";
      };
      urgency_low = {
        background = "#FDF6E3";
        foreground = "#657B83";
        timeout = 10;
      };
      urgency_normal = {
        background = "#FDF6E3";
        foreground = "#657B83";
        timeout = 10;
      };
      urgency_critical = {
        background = "#fdf6e3";
        foreground = "#657B83";
        timeout = 10;
      };
    };
 };
}
