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

      #Ignore maximize requests from all apps.
      window_rule = {
        name = "suppress-maximize-events";
        match = {class = ".*";};
        suppress_event = "maximize";
      };
    };
  };
}
