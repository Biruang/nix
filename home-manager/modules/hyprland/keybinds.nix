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
        #{
        #  _args = [
        #    (lib.generators.mkLuaInline "mainMod .. \" + D\"")
        #    (lib.generators.mkLuaInline "hl.dsp.exec_cmd(menu .. \" -show drun\")")
        #  ];
        #}
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
        #noctalia
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + D\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"panel-toggle launcher\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + S\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"panel-toggle control-center\")")
          ];
        }
        {
          _args = [
            (lib.generators.mkLuaInline "mainMod .. \" + comma\"")
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"settings-toggle\")")
          ];
        }
        {
          _args = [
            "ALT + Tab"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"window-switcher\")")
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
        #media keys
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"volume-up\")")
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"volume-down\")")
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"volume-mute\")")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"brightness-up\")")
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(ipc .. \"brightness-down\")")
          ];
        }
      ];
    };
  };
}
