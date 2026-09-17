{
  pkgs,
  user,
  ...
}: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      ${user} = {
        description = "default user";
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ["wheel" "networkmanager"];
      };
    };
  };

  #services.getty.autologinUser = biruang;
}
