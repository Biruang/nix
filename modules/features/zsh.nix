{
  self,
  inputs,
  ...
}: {
  flake.homeModules.myZsh = {
    config,
    pkgs,
    ...
  }: {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      initContent = ''
        PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
         %F{green}→%f "
        RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
        [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
        bindkey '^P' history-beginning-search-backward
        bindkey '^N' history-beginning-search-forward
      '';
    };
  };
}
