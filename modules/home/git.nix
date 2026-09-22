{
  self,
  inputs,
  ...
}: {
  flake.homeModules.myGit = {pkgs, ...}: {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = "Biruang";
          email = "saidovte@gmail.com";
        };
      };
    };
  };
}
