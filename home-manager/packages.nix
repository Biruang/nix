{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    telegram-desktop
    vscode
    firefox
    pavucontrol

    #utils
    brightnessctl
  ];
}
