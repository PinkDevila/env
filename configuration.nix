{ config, pkgs, ... }:{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    tmpOnTmpfs = true;
    tmpOnTmpfsSize = "90%";
    cleanTmpDir = true;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "pcie_aspm=off" 
      "pcie_acs_override=downstream,multifunction"
    ];
    blacklistedKernelModules = [
      "nvidia" "nouveau"
    ];
    kernelModules = [
      "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"
    ];
    extraModprobeConfig = "options vfio-pci ids=10de:1c82,10de:0fb9";
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
  

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    autoOptimiseStore = true;
  };
  networking.hostName = "PinkDevil"; # Define your hostname.
  networking.firewall.enable = false;

  time.timeZone = "Europe/Belgrade";

  networking.useDHCP = false;
  networking.interfaces.enp34s0.useDHCP = true;

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs;[fcitx5-mozc];
  };

  programs.dconf.enable = true;
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
  };
  environment.gnome = {
    excludePackages = with pkgs;[];
  };

  hardware = {
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  services.zerotierone = {
    enable = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet -r --time --cmd sway";
        user = "greeter";
      };
    };
  };
  xdg.portal = {
    enable = true;
    gtkUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    wlr.enable = true;
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
    extraGroups = [ "kvm" "audio" "wheel" "libvirtd" ];
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
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      inconsolata
      fira-code
      fira-code-symbols
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
        emoji = [ "Noto Color Emoji" ];
      };
  };
  };
  
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true; runAsRoot = true;
    };
    onBoot = "ignore";
    onShutdown = "shutdown";
  };
  services.sshd.enable = true;
  systemd = {
    tmpfiles = {
      rules = [
        #"f /dev/shm/looking-glass 0660 sera libvirtd -"
      ];
    };
    services = {
      create-swapfile = {
        serviceConfig.Type = "oneshot";
        wantedBy = [ "swap-swapfile.swap" ];
        script = ''
          ${pkgs.coreutils}/bin/truncate -s 0 /swapfile
          ${pkgs.e2fsprogs}/bin/chattr +C /swapfile
          ${pkgs.btrfs-progs}/bin/btrfs property set /swapfile compression none
        '';
      };
    };
  };
  system.stateVersion = "22.05";

}

