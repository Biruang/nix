{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.myDocker = {pkgs, ...}: {
    virtualisation.docker = {
      enable = true;
    };

    users.users.biruang.extraGroups = ["docker"];
  };
}
