{
  self,
  moduleWithSystem,
  inputs,
  lib,
  ...
}: {
  flake.nixosModules.desktop = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    nixModules = [
      inputs.noctalia-greeter.nixosModules.default
      self.nixosModules.openrgb
      self.nixosModules.core
    ];
    homeModules = with self.homeModules; [
      niri
      ghostty
      firefox
      obsidian
    ];
  in {
    imports = nixModules;

    # temp override until 8.3 version with fixes
    nixpkgs.overlays = [
      (final: prev: {
        xwayland-satellite = prev.xwayland-satellite.overrideAttrs (old: rec {
          version = "0.8.1";

          src = final.fetchFromGitHub {
            owner = "Supreeeme";
            repo = "xwayland-satellite";
            rev = "536bd32";
            hash = "sha256-BUE41HjLIGPjq3U8VXPjf8asH8GaMI7FYdgrIHKFMXA=";
          };

          cargoDeps = final.rustPlatform.fetchCargoVendor {
            inherit (old) pname;
            inherit version src;
            hash = "sha256-16L6gsvze+m7XCJlOA1lsPNELE3D364ef2FTdkh0rVY=";
          };
        });
      })
    ];
    environment.systemPackages = [pkgs.xwayland-satellite];

    programs = {
      amnezia-vpn.enable = true;
      niri.enable = true;
    };

    #portals for niri
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config.common.default = "*";
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
    };

    security.rtkit.enable = true;
    services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };

      displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          session.default = "niri";
          user.default = "biruang";
          cursor.size = 24;
          appearance = {
            scheme = "Synced";
            password_style = "default";
            hide_logo = true;
            scheme_selector_position = "hidden";
            power_buttons_position = "bottom-right";
          };
        };
        passwordless-sync-users = ["biruang"];
      };
    };

    hardware = {
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
      i2c.enable = true;
    };

    home-manager.users = {
      "biruang" = {
        imports = homeModules;
      };
    };
  });
}
