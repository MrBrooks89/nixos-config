{ pkgs, ... }:
{
        programs.zsh = {
                enable = true;
                enableCompletion = true;
                autosuggestion.enable = true;
                syntaxHighlighting.enable = true;
                sessionVariables = {
                        OLLAMA_HOST = "0.0.0.0:11434";
                };

                sessionPath = [ "$HOME/go/bin"];

                # Use initContent to source environment variables from the .env file 
                initContent = ''
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
