{ config, pkgs, ... }:{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "90%";
    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "nvidia-drm.modeset=1" 
    ];
    blacklistedKernelModules = [
    ];
    extraModprobeConfig = "";
    kernel = {
      sysctl = {
        "vm.max_map_count" = 2147483642;
      };
    };
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 6;
        consoleMode =  "max";
      };
      efi.canTouchEfiVariables = true;
    };
  };
  

  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.auto-optimise-store = true;
  };
  networking.enableIPv6 = false;
  networking.hostName = "pinkdevil";
  networking.firewall.enable = false;

  time.timeZone = "Europe/Belgrade";

  networking.useDHCP = false;
  networking.interfaces.enp34s0.useDHCP = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs;[fcitx5-mozc];
  };

  programs.dconf.enable = true;
  programs.cdemu.enable = true;

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    libinput = {
      enable = true;
      mouse = {
        naturalScrolling = true;
      };
    };
  };
  security.polkit.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs;[xdg-desktop-portal-gtk];
  };
  hardware = {
    nvidia = {
      prime = {
        sync.enable = true;
        nvidiaBusId = "PCI:26:0:0";
        amdgpuBusId = "PCI:25:0:0";
      };
      modesetting.enable = true;
    };
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs; [
      ];
  };
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -c 'startw'";
        user = "sera";
      };
    };
  };
  sound.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.sera = {
    isNormalUser = true;
    extraGroups = [ "cdrom" "kvm" "audio" "wheel" ];
    shell = pkgs.mksh;
  };
  nixpkgs = {
    config= {
      allowUnfree = true;
    };
  };

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      noto-fonts
      font-awesome
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      jetbrains-mono
      inconsolata
      migu
      ipafont
      kochi-substitute

    ];
    fontconfig = {
      defaultFonts = {
        monospace = [
          "JetBrains Mono"
          "IPAGothic"
          "Noto Sans Mono CJK KR"
          "Noto Sans Mono CJK JP"
          "Font Awesome 6 Free" 
        ];
        sansSerif = [
          "JetBrains Mono"
          "IPAGothic"
          "Noto Sans Mono CJK KR"
          "Noto Sans Mono CJK JP"
          "Font Awesome 6 Free" 
        ];
        serif = [
          "JetBrains Mono"
          "IPAPMincho"
          "Noto Sans Mono CJK KR"
          "Noto Sans Mono CJK JP"
          "Font Awesome 6 Free" 
        ];
        emoji = [
          "Font Awesome 6 Free" 
          "Noto Color Emoji"
        ];
      };
  };
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  services.sshd.enable = true;
    virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      extraPackages = with pkgs;[podman-compose];
    };
  };

#  systemd = {
#    tmpfiles = {
#      rules = [
#        "f /dev/shm/looking-glass 0660 sera libvirtd -"
#      ];
#    };
#    services = {
#    };
#  };
  system.stateVersion = "22.05";
}
