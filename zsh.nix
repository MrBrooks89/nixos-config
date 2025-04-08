{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      PATH = "$HOME/go/bin:$PATH";
      OLLAMA_HOST = "0.0.0.0:11434";
#      GOBIN = "$HOME/go/bin";
#      GOPATH = "$HOME/go/bin:$PATH";
   };

   # Use initExtra to source environment variables from the .env file
    initExtra = ''
      if [ -f "$HOME/.env" ]; then
        export $(cat $HOME/.env | xargs)
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
      "cat" = "bat";
      "ll" = "exa -al --icons";
      "ls" = "exa -a --icons";
      "lt" = "exa -a --tree --level=1 --icons";
    };
  };
}
