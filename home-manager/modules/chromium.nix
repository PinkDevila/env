{ config, pkgs, ... }: {
  programs.chromium = {
    enable  = true;
    package = pkgs.vivaldi;
    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
      }
    ];
  };
}
