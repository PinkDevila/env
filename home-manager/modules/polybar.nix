{config, pkgs, ...}:{
  services.polybar = {
    enable = true;
    config = {
      "bar/top" = {
         width = "100%";
         height = "16px";
         font-0 = "Fira Code:pixelsize=10";
         radius = 0;
         modules-center = "date";
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%d.%m.%y";
        time = "%H:%M";
        label = "%time%  %date%";
      };
    };
    script = "polybar top &";
  };
}
