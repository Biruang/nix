{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.mainConfiguration = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      self.nixosModules.mainHardware
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];

    environment.systemPackages = with pkgs; [
      firefox
      vscode
    ];
  };
}
