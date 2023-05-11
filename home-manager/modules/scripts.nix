{pkgs, ...}: let
  nvidia-run = pkgs.writeScriptBin "nvidia-run" ''
    #!/usr/bin/env bash
    export DXVK_FILTER_DEVICE_NAME="NVIDIA GeForce GTX 1050 Ti"
    export __NV_PRIME_RENDER_OFFLOAD=1 
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    "$@"
  '';
  screenshot = pkgs.writeScriptBin "screenshot" ''
    #!/usr/bin/env bash

    if [[ $XDG_SESSION_TYPE ==  "wayland" ]];then
      pgrep -x slurp >/dev/null || ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" -| ${pkgs.wl-clipboard}/bin/wl-copy -t image/png && pkill screenshot
    fi
  '';
      #${pkgs.maim}/bin/maim -Buso |${pkgs.xclip}/bin/xclip -selection clipboard -t image/png
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

    export LD_LIBRARY_PATH=/run/opengl-driver/lib
    if [[ $XDG_SESSION_TYPE ==  "wayland" ]];then
      pgrep -x wf-recorder > /dev/null || nvidia-run wf-recorder -aeasyeffects_sink.monitor -f "$(date "+%d_%m_%y_-_%H_%M").mp4" -c h264_nvenc -p qp=30 -C aac && pkill -SIGINT wf-recorder
    else
      pgrep -x ffmpeg >/dev/null || ffmpeg -y -framerate 60 -f x11grab -i :0.0 -f pulse -i easyeffects_sink.monitor -c:v hevc_nvenc -qp 30 -threads 0 test.mp4 && pkill -SIGINT ffmpeg
    fi
  '';
  startw = pkgs.writeScriptBin "startw" ''
    #!/usr/bin/env sh

    export _JAVA_AWT_WM_NONREPARENTING=1
    export QT_STYLE_OVERRIDE=gtk2
    sway --unsupported-gpu
    #Hyprland
  '';
  proton = pkgs.writeScriptBin "proton" ''
    #!/usr/bin/env sh

    GAMES=$HOME/Games
    PROTON="${pkgs.steam-run}/bin/steam-run ${pkgs.python3}/bin/python3 $GAMES/proton/proton run"
    EXE="$@"
    export STEAM_COMPAT_DATA_PATH=$GAMES/prefix
    export STEAM_COMPAT_CLIENT_INSTALL_PATH="$HOME/.steam/"

    $PROTON $EXE
  '';
  protondesk = pkgs.writeScriptBin "protondesk" ''
    #!/usr/bin/env sh

    proton explorer.exe /desktop="$1",1920x1080 "$@"
  '';
  protonserver = pkgs.writeScriptBin "protonserver" ''
    #!/usr/bin/env sh

    BIN=$HOME/Games/proton/files/bin/

    export WINEPREFIX=$HOME/Games/prefix/pfx
    export WINE=$BIN/wine

    PROTON="${pkgs.steam-run}/bin/steam-run $BIN/wineserver -k"

    $PROTON "$@"
  '';

  menu = pkgs.writeScriptBin "menu" ''
    #!/usr/bin/env sh
    ${pkgs.bemenu}/bin/bemenu-run --nf '#52676f' --af '#52676f' --tb '#fdf6e3' --fb '#fdf6e3' --hb '#fdf6e3' --ab '#fdf6e3' --nb '#fdf6e3' -p "" --fn 'monospace 12'

  '';
  browser = pkgs.writeScriptBin "browser" ''
    MOZ_ENABLE_WAYLAND=1 firefox
  '';
  wallpaper = pkgs.writeScriptBin "wallpaper" ''
    #!/usr/bin/env sh
    pgrep -x wbg > /dev/null || ${pkgs.wbg}/bin/wbg ~/.config/wall.png && pkill wbg
  '';

  f = pkgs.writeScriptBin "f" ''
    #!/usr/bin/env sh

    case "$@" in
      *youtube.com* | *youtu.be* | *.mp3 | *.mp4)mpv "$@"
        ;;
      https* | http*) browser "$@"
        ;;
      *.pdf) zathura "$@"
        ;;
      *.exe) proton "$@"
        ;;
      *.png | *.jpg) nsxiv "$@"
        ;;
      *) $EDITOR "$@"
        ;;
    esac
  '';
in {
  programs.lesspipe.enable = true;
  home.packages = [
    browser
    f
    menu
    nvidia-run
    proton
    protondesk
    protonserver
    record
    screenshot
    startw
    sysrebuild
    sysupgrade
    wallpaper
  ];
}
