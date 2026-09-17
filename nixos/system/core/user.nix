{pkgs, ...}: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      biruang = {
        description = "default user";
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = ["wheel" "networkmanager"];
      };
    };
  };

  #services.getty.autologinUser = biruang;
}
