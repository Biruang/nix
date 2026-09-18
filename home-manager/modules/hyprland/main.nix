{lib, ...}: {
  wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    #conflicts with UWSM
    systemd.enable = false;
    #xwayland.enable = true;

    settings = {
      monitor = {
        output = "";
        mode = "preferred";
        position = "auto";
        scale = "auto";
      };

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

      window_rule = [
        #Ignore maximize requests from all apps.
        {
          name = "suppress-maximize-events";
          match = {class = ".*";};
          suppress_event = "maximize";
        }
        #Noctalia settings window
        {
          match = {class = "dev.noctalia.Noctalia";};
          float = true;
          size = [1080 920];
        }
      ];

      workspace_rule = [
        {
          workspace = "1";
          monitor = "DP-1";
          persistent = true;
          default_name = "web";
        }
        {
          workspace = "2";
          monitor = "DP-1";
          persistent = true;
          default_name = "code";
        }
        {
          workspace = "3";
          monitor = "DP-1";
          persistent = true;
          default_name = "chat";
        }
        {
          workspace = "4";
          monitor = "DP-1";
          persistent = true;
          default_name = "game";
        }
        {
          workspace = "5";
          monitor = "DP-1";
          persistent = true;
          default_name = "design";
        }
      ];

      layer_rule = [
        {
          name = "noctalia";
          match = {
            namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$";
          };
          no_anim = true;
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];
    };
  };
}
