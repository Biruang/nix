{
  networking = {
    networkmanager.enable = true;
    wireless.enable = true;
  };
  services.unbound = {
    enable = true;
  };
  programs.nm-applet.enable = true;
}
