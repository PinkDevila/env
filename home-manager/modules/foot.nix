{config, pkgs, ...}:{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "tmux-256color";
        font = "Fira Code:size=12";
      };
      colors = {
        alpha = "0.9";
      };
    };
  };
}
