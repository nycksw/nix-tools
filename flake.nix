{
  description = "Minimal Home Manager for tools, not dotfiles.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      # This overlay fixes packages that break with python313 but don't have
      # a python312Packages build available.
      # (Fixes: "future-1.0.0 not supported for interpreter python3.13".)
      py312Bins = [ "netexec" "enum4linux-ng" ];
      py312Overlay = final: prev:
        prev.lib.genAttrs py312Bins (pkgName:
          (prev.${pkgName}).override { python3 = prev.python312; }
      );

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ py312Overlay ];
        config.allowUnfree = true;
      };

    in
    {
      homeConfigurations."e" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
}
