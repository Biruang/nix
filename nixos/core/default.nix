{lib, ...}: {
  options = {
    core.enable = lib.mkEnableOption "enables core system module";
  };

  imports = [
    ./boot.nix
    ./locale.nix
    ./nix.nix
    ./zram.nix
    ./user.nix
    ./nh.nix
  ];
}
