{ lib, ... }: {
  wayland.windowManager.hyprland = {
    settings = {
      on = {
        _args = [
          "hyprland.start"
          (
            lib.generators.mkLuaInline ("function ()" +
            " hl.exec_cmd(terminal)" +
            " hl.exec_cmd('waybar & firefox')" + 
            " end")
          )
        ];
      };
    };
  };
}