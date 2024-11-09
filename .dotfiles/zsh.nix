{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    #defaultKeymap = "emacs";
    localVariables = {
      PROMPT = "%F{green} ➜ %f";
      RPROMPT = "%F{blue}%~ ";
    };
    profileExtra = ''
      if [[ "$(tty)" = "/dev/tty1" ]]; then
        pgrep i3 || startx $(which i3)
      fi
    '';
    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.zsh-autopair;
        file = "share/zsh/zsh-autopair/autopair.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.zsh";
      }
    ];
    shellAliases = {
      #"cat" = "bat";
      "ll" = "exa -al --icons";
      "ls" = "exa -a --icons";
      "lt" = "exa -a --tree --level=1 --icons";
    };
  };
}
