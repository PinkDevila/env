{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    home-manager = {
      url = "github:/nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland  = { 
      url = "github:nix-community/nixpkgs-wayland";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs-wayland
    , self
    , nixpkgs
    , home-manager
    , hyprland
  }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
    user = "sera";
  in rec{
    nixosConfigurations = {
      ${user} = lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
            hyprland.nixosModules.default {programs.hyprland.enable = true;}
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            nixpkgs.overlays = [
              nixpkgs-wayland.overlay
              (final: prev: { 
                bemenu = prev.bemenu.overrideAttrs (old: {
                  patches = [ 
                    ./patches/bemenu
                  ];
                });
                st = prev.st.overrideAttrs (old: {
                  src = prev.fetchgit {
                    url = "https://git.suckless.org/st";
                    rev = "211964d56ee00a7d46e251cbc150afb79138ae37";
                    sha256 = "1s3pq6pggagi0598wycfyy1gsiqy0yv7ylng9wb3fi7frkppy084";
                  };
                  patches = [./patches/st];
                });
                discord = prev.discord.override { withOpenASAR = true; };
                tofi = prev.tofi.overrideAttrs (old: {
                  src = prev.fetchFromGitHub {
                    owner = "philj56";
                    repo = "tofi";
                    rev = "574eff0df1aff9bdc6d32939a03312cc08803de3";
                    sha256 = "sha256-lmG6cES210WxqhzN8nDS0+IJ6LSNXt3f8lqQdwC7Izw=";
                  };
                  patches = [ 
                    ./patches/tofi
                  ];
                });
              })
            ];

            home-manager.users.${user} = {
              imports = [
                ./home-manager/home.nix
              ];
            };
          }
        ];
      };
    };
  };
}
