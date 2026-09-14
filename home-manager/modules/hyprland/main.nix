{
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = { 
    enable = true;
    systemd.enable = false;
    xwayland.enable = true;
    settings = {
      #env = [
      #  "NIXOS_OZONE_WL,1"
      #  "XDG_CURRENT_DESKTOP,Hyprland"
      #  "XDG_SESSION_TYPE,wayland"
      #  "XDG_SESSION_DESKTOP,Hyprland"
      #  "QT_QPA_PLATFORM,wayland"
      #  "XDG_SCREENSHOTS_DIR,$HOME/screens"
      #];
      #"$mod" = "SUPER";
      #"terminal" = "alacritty";
      #"menu" = "fuzzel";

      #monitor = [
      #  ",preferred,auto,1"
      #];

      #decoration = {
      #  shadow_offset = "0 5";
      #  "col.shadow" = "rgba(00000099)";
      #};
    };
  };
}
