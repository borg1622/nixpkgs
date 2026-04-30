{config, pkgs, home, ...}:
{
  # #### This file is intended to be included by a home-manager configugration
  # #### -> home-manager.users.*.imports = [ "<thisfile>" ];

  imports = [ 
    ./polybar.colors.nix
    ./polybar.modules.nix
    ./polybar.bars.nix
  ];

  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support     = true;
      pulseSupport  = true;
      iwSupport     = true;
      githubSupport = true;
    };
    settings = {
      "global/wm" = {
        margin.bottom = 0;
        margin.top    = 0;
      };
      
      "settings" = {
        screenchange.reload     = false;
        compositing.background  = "source";
        compositing.foreground  = "over";
        compositing.overline    = "over";
        compositing.underline   = "over";
        compositing.border      = "over";
        pseudo.transparency     = false;
      };

    };
    # config = {
      
    # };
    # extraConfig = ''
    # 
    # '';

    script = ''

      killall -w -r "polybar" -o 5s

      while IFS="\n" read -r m; do
        m_split=($m)
        mon="''${m_split[0]}"
        res="''${m_split[1]}"
        
        echo "row: $m"
        echo "monitor: $mon"
        echo "resolution: $res"
        echo "elements: ''${#m_split[@]}"
        
        if [ $res == '1366x768' ]; then # internal screen
          MONITOR=$mon polybar top &
          MONITOR=$mon polybar bottom &
        elif [ $res == '1920x1200' ]; then # FHD Monitor
          MONITOR=$mon polybar top-ext &
          MONITOR=$mon polybar bottom &
        elif [ $res == '1920x1080' ]; then # FHD Monitor
          MONITOR=$mon polybar top-ext &
          MONITOR=$mon polybar bottom &
        elif [ $res == '2560x1440' ] || [ $res == '3072x1728' ]; then # DELL 24" W179
          MONITOR=$mon polybar top-ext &
          MONITOR=$mon polybar bottom &
          echo 'DELL 24" W179'
        elif [ $res == '3840x2160' ]; then # UHD Monitor
          MONITOR=$mon polybar top-uhd &
          MONITOR=$mon polybar bottom-uhd &
          echo "UHD Monitor"
        else
          MONITOR=$mon polybar top-ext &
          MONITOR=$mon polybar bottom-uhd &
          echo "else"
        fi
      done < <(polybar --list-monitors | tr -d ":" | grep -oP '^[a-zA-Z]+(-[0-9])?\s[0-9]+x[0-9]+(?=\+.+)')
    '';
  };

}
