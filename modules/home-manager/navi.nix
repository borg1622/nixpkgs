{config, home, ...}:
{
  # #### This file is intended to be included by a home-manager configugration
  # #### -> home-manager.users.*.imports = [ "<thisfile>" ];
  programs.navi = {
      enable = true;
      settings = {
        style = {
          tag = {
            width_percentage = 15;
            min_width = 15;
          };
          comment = {
            width_percentage = 40;
            min_width = 40;
          };
          snipper = {
            color = "white";
          };
          
        };
        shell.command = "zsh";  # todo: use variable
        cheats = {
          paths = [
            # "${config.xdg.configHome}/navi/cheats/"
            # "~/.local/share/navi/cheats/"  # todo: replace '${config.users.users.${user}.home}/.local/share/' by ${config.home-manager.users.${user}.xdg.dataHome}
            "${config.xdg.dataHome}/navi/cheats/"  # todo: replace '${config.users.users.${user}.home}/.local/share/' by ${config.home-manager.users.${user}.xdg.dataHome}
          ];
        };
      };
   };

  # home-manager.users.${home.username} = { pkgs, ... }: {
  # https://github.com/denisidoro/navi/blob/master/docs/cheatsheet_syntax.md
    xdg.dataFile."navi/cheats/dirk.cheat".text = ''
      % cat, dirk
      # bat: cat replacement, pretty print files
      bat 

      % cat, dirk
      # bat: cat replacement, pretty print binary files (with )non-printable characters like space, tab or newline
      bat -A --tabs <characters>
      '';

}