{pkgs, config, ...}:{
  programs.bash = {
    enable = true;

    shellOptions = [
      "autocd"
    ];
    bashrcExtra = ''
      set -o vi
    '';
  };
}
