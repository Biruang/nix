{ config, user, ... }: {
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    activeConfig = "default";
    configs = {
      #symlink only for config edit livereload
      default = config.lib.file.mkOutOfStoreSymlink
        "/home/${user}/nix/home-manager/modules/quickshell";
      #hard path for reproductivity
      #default = builtins.path { path = ./.; };
    };
  };
}