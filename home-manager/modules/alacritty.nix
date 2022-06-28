{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        family = "Fira Code";
      };
       colors = {
        primary = {
          background = "#1c1e27";
          foreground = "#e5e5e5";
        };

        normal = {
          black   = "#1c1e27";
          red     = "#ff4040";
          green   = "#bada55";
          yellow  = "#fff159";
          blue    = "#60bdf4";
          magenta = "#f64a8a";
          cyan    = "#00bcbc";
          white   = "#cccccc";
        };

        bright = {
          black   = "#242732";
          red     = "#ff4040";
          green   = "#bada55";
          yellow  = "#fff159";
          blue    = "#60bdf4";
          magenta = "#f64a8a";
          cyan    = "#00bcbc";
          white   = "#dfdfdf";
        };
      };
      window = {
        opacity = 0.8;
      };
    };
  };
}
