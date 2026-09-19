{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    config,
    ...
  }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        input = {
          keyboard = {
            xkb.layout = "us,ru";
          };
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 5;

        binds = {
          "Mod+Q".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+C".close-window = [];
          "Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+R".switch-preset-column-width = [];

          "Mod+Left".focus-column-left = [];
          "Mod+Right".focus-column-right = [];
          "Mod+Up".focus-window-up = [];
          "Mod+Down".focus-window-down = [];
        };
      };
    };
  };
}
