{pkgs, ...}: let
  sysupgrade = pkgs.writeScriptBin "sysupgrade" ''
    #!/usr/bin/env bash
    nix flake update $HOME/.config/env
    sudo nixos-rebuild switch --flake $HOME/.config/env#$USER
  '';
  sysrebuild = pkgs.writeScriptBin "sysrebuild" ''
    #!/usr/bin/env bash
    sudo nixos-rebuild switch --flake $HOME/.config/env#$USER
  '';
  record = pkgs.writeScriptBin "record" ''
    #!/usr/bin/env bash
    pgrep -x wf-recorder > /dev/null || wf-recorder  && pkill -SIGINT wf-recorder
  '';
in {
  home.packages = [
    sysupgrade
    sysrebuild
    record
  ];
}
