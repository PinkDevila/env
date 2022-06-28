{ config, pkgs, ... }: {
  programs.chromium = {
    enable  = true;
    package = pkgs.vivaldi;
    extensions = [
      {
        id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; #ublock
      } # ublock origin
      {
        id = "doojmbjmlfjjnbmnoijecmcbfeoakpjm"; #NoScript
      }

      {
        id = "dcpihecpambacapedldabdbpakmachpb";
        updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
      }
    ];
  };
}
