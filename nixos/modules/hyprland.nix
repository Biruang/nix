{pkgs, ...}: {
  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables = {
    # Optional, hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Hint for QT apps to use wayland with xcd fallback
    QT_QPA_PLATFORM = "wayland;xcb";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [mesa];
  };
}
