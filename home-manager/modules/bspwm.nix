{config, pkgs, ...}:{
  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      "*" = ["一" "二" "三" "四" "五"];
    };    

    settings = {
      border_width = 0;
      window_gap = 0;
      ignore_ewmh_focus = true;
    };
  };
}
