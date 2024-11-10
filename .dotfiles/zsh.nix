{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      PATH = "$HOME/go/bin:$PATH";
      ARUBA_ACCESS_TOKEN="your_token_here";

   };
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
      "cat" = "bat";
      "ll" = "exa -al --icons";
      "ls" = "exa -a --icons";
      "lt" = "exa -a --tree --level=1 --icons";
    };
  };
}
