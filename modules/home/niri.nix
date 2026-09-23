{
  self,
  moduleWithSystem,
  inputs,
  ...
}: {
  flake.homeModules.niri = moduleWithSystem ({
    pkgs,
    self',
    inputs',
    ...
  }: let
    modules = [
      inputs.niri.homeModules.niri
      self.homeModules.noctalia
    ];
  in
    {config, ...}: {
      imports = modules;
      programs.niri = {
        enable = true;

        settings = {
          spawn-at-startup = [
            {argv = ["noctalia"];}
          ];
          #to omit client-side windows decorations
          prefer-no-csd = true;

          #skip annoying overlay
          hotkey-overlay = {
            skip-at-startup = true;
          };

          input = {
            keyboard = {
              xkb = {
                layout = "us,ru";
                variant = ",";
                options = "grp:alt_shift_toggle";
              };
              track-layout = "window";
            };
          };
          environment = {
            CLUTTER_BACKEND = "wayland";
            MOZ_ENABLE_WAYLAND = "1";
            MOZ_USE_XINPUT2 = "1";

            #GTK4 dead keys fallback
            GTK_IM_MODULE = "simple";
            GDK_BACKEND = "wayland,x11";
            # Hint for QT apps to use wayland with xcd fallback
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            # Optional, hint Electron apps to use Wayland
            NIXOS_OZONE_WL = "1";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";

            XDG_SESSION_TYPE = "wayland";
            XDG_CURRENT_DESKTOP = "niri";
          };

          outputs = {
            "HDMI-A-1" = {
              mode = {
                width = 2560;
                height = 1440;
                refresh = 119.961;
              };
              scale = 1.0;
              position = {
                x = 0;
                y = 0;
              };
              variable-refresh-rate = false; # on-demand=true
              focus-at-startup = true;
            };
          };

          layout = {
            background-color = "transparent";
            gaps = 0;

            focus-ring = {
              enable = true;
              width = 1;
            };

            preset-column-widths = [
              #{proportion = 1. / 3.;}
              {proportion = 1. / 2.;}
              {proportion = 2. / 3.;}
              {proportion = 1.;}
            ];
          };

          workspaces = {
            "01-main" = {
              open-on-output = "HDMI-A-1";
              name = "main";
            };
            "02-browser" = {
              open-on-output = "HDMI-A-1";
              name = "browser";
            };
            "03-discord" = {
              open-on-output = "HDMI-A-1";
              name = "discord";
            };
            "04-music" = {
              open-on-output = "HDMI-A-1";
              name = "music";
            };
          };

          binds = with config.lib.niri.actions; let
            # Run `noctalia msg --help` to see available commands, use `less` to search output
            noctalia = cmd:
              [
                "noctalia"
                "msg"
              ]
              ++ (pkgs.lib.splitString " " cmd);
          in {
            "Mod+Q".action.spawn-sh = "ghostty";
            "Mod+C".action = close-window;
            "Mod+R".action = switch-preset-column-width;
            #focus binds
            "Mod+Left".action = focus-column-left;
            "Mod+Right".action = focus-column-right;
            "Mod+Down".action = focus-workspace-down;
            "Mod+Up".action = focus-workspace-up;
            "Mod+T".action = toggle-window-floating;
            "Mod+F".action = fullscreen-window;
            #named workspaces navigation
            "Mod+1".action = focus-workspace "main";
            "Mod+2".action = focus-workspace "browser";
            "Mod+3".action = focus-workspace "discord";
            "Mod+4".action = focus-workspace "music";
            #named workspaces move
            "Mod+Shift+1".action.move-column-to-workspace = "main";
            "Mod+Shift+2".action.move-column-to-workspace = "browser";
            "Mod+Shift+3".action.move-column-to-workspace = "discord";
            "Mod+Shift+4".action.move-column-to-workspace = "music";
            #move binds
            "Mod+Shift+Left".action = move-column-left;
            "Mod+Shift+Right".action = move-column-right;
            "Mod+Shift+Down".action = move-column-to-workspace-down;
            "Mod+Shift+Up".action = move-column-to-workspace-up;
            #screenshots
            "Mod+X".action.screenshot = {};
            "Mod+Shift+X".action.screenshot-screen = {};
            #core binds for noctalia
            "Mod+D".action.spawn = noctalia "panel-toggle launcher";
            #"Mod+S".action.spawn = noctalia "panel-toggle control-center";
            "Mod+Comma".action.spawn = noctalia "settings-toggle";
            "Alt+Tab".action.spawn = noctalia "window-switcher";
            #noctalia audio
            "XF86AudioRaiseVolume".action.spawn = noctalia "volume-up";
            "XF86AudioLowerVolume".action.spawn = noctalia "volume-down";
            "XF86AudioMute".action.spawn = noctalia "volume-mute";
            #noctalia brightness
            "XF86MonBrightnessUp".action.spawn = noctalia "brightness-up";
            "XF86MonBrightnessDown".action.spawn = noctalia "brightness-down";
            #noctalia media
            "XF86AudioPlay".action.spawn = noctalia "media toggle";
            "XF86AudioNext".action.spawn = noctalia "media next";
            "XF86AudioPrev".action.spawn = noctalia "media previous";
          };

          window-rules = [
            {
              geometry-corner-radius = {
                bottom-left = 0.0;
                bottom-right = 0.0;
                top-left = 0.0;
                top-right = 0.0;
              };
              clip-to-geometry = true;
            }
            #noctalia windows
            {
              matches = [
                {
                  app-id = "dev.noctalia.Noctalia";
                }
              ];
              open-floating = true;
              default-column-width = {fixed = 1080;};
              default-window-height = {fixed = 920;};
            }
          ];
          debug = {
            honor-xdg-activation-with-invalid-serial = [];
          };
        };
      };
    });
}
