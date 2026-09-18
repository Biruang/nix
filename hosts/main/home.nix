{
  inputs,
  stateVersion,
  user,
  pkgs,
  ...
}: {
  imports = [
    inputs.noctalia.homeModules.default
    inputs.niri.homeModules.niri
    ../../home/noctalia.nix
    ../../home/niri.nix
    ../../home/git.nix
    ../../home/zsh.nix
    ../../home/alacritty.nix
    ../../home/firefox.nix
    ../../home/vscode.nix
    ../../home/obsidian.nix
  ];

  #allow satan to your soul EXSPLICITLY
  #nixpkgs.config = {
  #  allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) ["yandex-music"];
  #};

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = stateVersion;
    keyboard = null;
    packages = with pkgs; [
      #music service from satan(tm)
      yandex-music
      telegram-desktop
    ];
  };
}
