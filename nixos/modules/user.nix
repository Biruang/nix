{ pkgs, user, ... }: {
  #programs.zsh.enable = true;

  users = {
    #defaultUserShell = pkgs.zsh;
    users.${user} = {
      description = "default user";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      #packages = with pkgs; [];
    };
  };

  #services.getty.autologinUser = user;
}