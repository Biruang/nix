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
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.wrappedNiri;
    };
  };

  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.wrappedNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        #spawn-at-startup = [
        #  (lib.getExe self'.packages.myNoctalia)
        #];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us,ua";

        layout.gaps = 5;

        binds = {
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+Q".close-window = null;
          "Mod+S".spawn-sh = "ipc call launcher toggle";
        };
      };
    };
  };
}
