{pkgs, ...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    sessionVariables = {
      PATH = "$HOME/go/bin:$PATH";
      OLLAMA_HOST = "0.0.0.0:11434";
      DISPLAY = ":0";
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
      {
        name = "zsh-completions";
        src = pkgs.zsh-completions;
        file = "share/zsh-completions/zsh-completions.zsh";
      }
    ];
    shellAliases = {
      "cat" = "bat";
      "ll" = "exa -al --icons";
      "ls" = "exa -a --icons";
      "lt" = "exa -a --tree --level=1 --icons";
      "nn" = "nvim";
      "vim" = "nvim";
      "ping" = "fping -c 25";
    };

    # Use initContent to source environment variables from the .env file
    initContent = ''
      if [ -f "$HOME/.env" ]; then
        while IFS= read -r line; do
          if [[ -n "$line" && "$line" != \#* ]]; then
            export "$line"
          fi
        done < "$HOME/.env"
      fi
    '';
  };
}
