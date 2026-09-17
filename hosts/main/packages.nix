{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    #for Qt wayland support
    libsForQt5.qt5.qtwayland
    qt6Packages.qtwayland
    #LSP for nix
    nixd
    #secure secrets management
    #secretspec
  ];
}
