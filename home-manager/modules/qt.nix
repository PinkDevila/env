{config, pkgs, ...}:{
  qt = {
    enable = true;
    platformTheme = "gtk";
    
    style = {
      name = "gtk2";
    };
  };
}
