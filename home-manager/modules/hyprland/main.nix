{ lib, ... }: {
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = { 
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    systemd.enable = false;
    xwayland.enable = true;

    settings = {
      mainMod = {
        _var = "SUPER";
      };
      menu = {
        _var = "rofi";
      };
      terminal = {
        _var = "alacritty";
      };

      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = "auto";
      };

      config = {
        general = {
          gaps_in  = 0;
          gaps_out = 0;
          border_size = 1;

          col = {
            active_border = {
               colors = [
                "rgba(33ccffee)"
                "rgba(00ff99ee)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(595959aa)";
          };

          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        dwindle = {
          preserve_split = true;
        };

        decoration = {
          rounding = 0;
          rounding_power = 2;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "0xee1a1a1a";
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
        };

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";
          kb_rules = "";

          follow_mouse = 1;

          sensitivity = 0;

          touchpad = {
            natural_scroll = false;
          };
        };
      };

      bind = [
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + Q\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
            { locked = true; }
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + C\"")
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        #{
        #  _args = [
        #    (lib.generators.mkLuaInline "mainMod .. \" + M\"")
        #    (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
        #    { locked = true; }
        #  ];
        #}
        #{
        #  _args = [
        #    (lib.generators.mkLuaInline "mainMod .. \" + E\"")
        #    (lib.generators.mkLuaInline "hl.dsp.exec_cmd(fileManager)")
        #    { locked = true; }
        #  ];
        #}
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + V\"")
            (lib.generators.mkLuaInline "hl.dsp.window.float({ action = 'toggle' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + R\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu .. \" -show drun\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + P\"")
            (lib.generators.mkLuaInline "hl.dsp.window.pseudo()")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + J\"")
            (lib.generators.mkLuaInline "hl.dsp.layout('togglesplit')")
          ];
        }
        # move focus with mainMod + arrow keys
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + left\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'left' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + right\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'right' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'up' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'down' })")
          ];
        }
        # scroll through workspaces mainMod + scroll
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + mouse_down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 'e+1' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + mouse_up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 'e-1' })")
          ];
        }
      ];

      env = [
      #  "NIXOS_OZONE_WL,1"
      #  "XDG_CURRENT_DESKTOP,Hyprland"
      #  "XDG_SESSION_TYPE,wayland"
      #  "XDG_SESSION_DESKTOP,Hyprland"
      #  "QT_QPA_PLATFORM,wayland"
      #  "XDG_SCREENSHOTS_DIR,$HOME/screens"
        {
          _args = [
            "XCURSOR_SIZE"
            "24"
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            "24"
          ];
        }
      ];

      #Ignore maximize requests from all apps.
      window_rule = {
        name = "suppress-maximize-events";
        match = { class = ".*"; };
        suppress_event = "maximize";
      };
    };
  };
}
