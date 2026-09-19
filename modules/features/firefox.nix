{
  self,
  inputs,
  ...
}: {
  flake.homeModules.myFirefox = {
    pkgs,
    user,
    ...
  }: {
    programs.firefox = {
      enable = true;

      profiles.default.search = {
        force = true;
        default = "ddg";
        privateDefault = "ddg";

        #apply Nix to search engine to increase the pain
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "Nix Options" = {
            urls = [
              {
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };

          "NixOS Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php";
                params = [
                  {
                    name = "search";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nw"];
          };
        };
      };

      policies = {
        #updates and background services
        AppAutoUpdate = false;
        BackgroundAppUpdate = false;

        #feature disabling
        DisableBuiltinPDFViewer = true;
        DisableFirefoxStudies = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxScreenshots = true;
        DisableForgetButton = true;
        DisableMasterPasswordCreation = true;
        DisableProfileImport = true;
        DisableProfileRefresh = true;
        DisableSetDesktopBackground = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFormHistory = true;
        DisablePasswordReveal = true;

        #UI and behavior
        DisplayMenuBar = "never";
        DontCheckDefaultBrowser = true;
        DefaultDownloadDirectory = "/home/${pkgs.stdenv.hostPlatform.system}/downloads";

        #extensions
        ExtensionSettings = let
          moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
        in {
          "uBlock0@raymondhill.net" = {
            install_url = moz "ublock-origin";
            installation_mode = "force_installed";
            updates_disabled = true;
          };
          "pywalfox@frewacom.org" = {
            install_url = moz "pywalfox";
            installation_mode = "force_installed";
            updates_disabled = true;
          };
        };
      };
    };
  };
}
