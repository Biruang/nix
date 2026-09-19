{
  self,
  inputs,
  ...
}: {
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;

      settings = {
        #spawn-at-startup = [
        #  (lib.getExe self'.packages.myNoctalia)
        #];

        input = {
          keyboard = {
            xkb.layout = "us,ua";
          };
        };

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        layout.gaps = 5;

        binds = {
          "Mod+Q".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+C".close-window = null;
          #"Mod+D".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
        };
      };
    };
  };
}
