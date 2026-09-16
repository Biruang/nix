{
  lib,
  map,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      bind = [
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + Q\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(terminal)")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + C\"")
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + R\"")
            (lib.generators.mkLuaInline "hl.dsp.layout('colresize +conf')")
          ];
        }
        #{
        #  _args = [
        #    (lib.generators.mkLuaInline "mainMod .. \" + E\"")
        #    (lib.generators.mkLuaInline "hl.dsp.exec_cmd(fileManager)")
        #    { locked = true; }
        #  ];
        #}
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + V\"")
            (lib.generators.mkLuaInline "hl.dsp.window.float({ action = 'toggle' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + D\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu .. \" -show drun\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + P\"")
            (lib.generators.mkLuaInline "hl.dsp.window.pseudo()")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + J\"")
            (lib.generators.mkLuaInline "hl.dsp.layout('togglesplit')")
          ];
        }
        # move focus with mainMod + arrow keys
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + left\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'left' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + right\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'right' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'up' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ direction = 'down' })")
          ];
        }
        # scroll through workspaces mainMod + scroll
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + mouse_down\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 'e+1' })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + mouse_up\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 'e-1' })")
          ];
        }
        # resize and drag with mainMod + mouse
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + mouse:272\"")
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
            {mouse = true;}
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + mouse:273\"")
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
            {mouse = true;}
          ];
        }
        #switch workspace with mainMod + [0-9]
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + 1\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = '0'})")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + 2\"")
            (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = '1' })")
          ];
        }
        #move window to workspace with mainMode + SHIFT + [0,9]
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + SHIFT\" .. \" + 1\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 0 })")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + SHIFT\" .. \" + 2\"")
            (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
          ];
        }
      ];
    };
  };
}
