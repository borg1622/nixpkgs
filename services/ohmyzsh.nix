{ config, pkgs, ... }:

{

    users.defaultUserShell = pkgs.zsh;

    environment = {
      systemPackages = with pkgs; [
        zsh
        zsh-powerlevel10k
        zsh-bd
        zsh-history
        zsh-nix-shell
      ];

      etc = {
        "zsh.p10k.local"= {
          source = ../lib/etc/p10k.zsh;
        };
        "zshrc.local" = {
          text = ''
            [[ ! -f /etc/zsh.p10k.local ]] || source /etc/zsh.p10k.local
          '';
        };
      };
    };

    programs.zsh = {
      enable = true;

      # todo: move to etc, if possible
      promptInit = ''
        ZSH_THEME="powerlevel10k"

        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

        # todo: check why
        export LESSHISTFILE=/dev/null
      '';

      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = ["man"];
        customPkgs = with pkgs; [
           nix-zsh-completions
    #      zsh-completions
    #      zsh-you-should-use
    #      zsh-autosuggestions
    #      zsh-command-time
        ];

      };
    };




}
