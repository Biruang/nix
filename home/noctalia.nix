{
  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      bar.default = {
        enabled = true;
        position = "top";
        concave_edge_corners = false;
        margin_ends = 0;
        radius = 0;

        start = [
          "launcher"
          "wallpaper"
          "workspaces"
        ];
        center = ["clock"];
        end = [
          "media"
          "tray"
          "notifications"
          "clipboard"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "control-center"
          "session"
        ];
      };

      wallpaper = {
        enabled = true;
        default.path = "../assets/default.jpg";
      };
    };
  };
}
