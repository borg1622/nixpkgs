{ config, pkgs, inputs, ... }:

let
  # unstable = import <nixos-unstable> {
  #   config.allowUnfree = true;
  # };
in
{


  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.histSize = 5000;
  programs.zsh.promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

  users.users.root.shell = pkgs.zsh;

  environment.systemPackages = with pkgs; [
    # unstable.zsh-powerlevel10k
    zsh-powerlevel10k
    zsh
#    zsh-history
    zsh-nix-shell
 #   zsh-git-prompt
    oh-my-zsh
    zsh-completions
    zsh-command-time
    zsh-you-should-use
    zsh-fast-syntax-highlighting
    nix-zsh-completions
  ];

}
