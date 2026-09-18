{config, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    initContent = ''
      # Start UWSM
      #if uwsm check may-start > /dev/null && uwsm select; then
      #  exec systemd-cat -t uwsm_start uwsm start default
      #fi

      # Start with USM bypassing shell select
      #if uwsm check may-start; then
      #  exec uwsm start hyprland.desktop
      #fi
    '';
  };
}
