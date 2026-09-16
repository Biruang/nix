{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    amnezia-vpn
    #for Qt wayland support
    libsForQt5.qt5.qtwayland
    qt6Packages.qtwayland
    #LSP for nix
    nixd
  ];
}
