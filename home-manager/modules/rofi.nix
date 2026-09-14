{ pkgs, ... }: {
  programs.rofi = {
    enable = true;
    #theme = "Arthur";
    #font = "sans-serif";
    package = pkgs.rofi;
    modes = [
      "drun"
      "run"
      "window"
      "ssh"  
    ];
    extraConfig = {
      show-icons = true;
    };
  };
}