{ inputs, outputs, home-manager, lib, config, pkgs, ... }:

let 
  user = "dmo";
in
{

  imports =
  [
      # <home-manager/nixos>
      

      # If you want to use modules your own flake exports (from modules/home-manager):
      # outputs.homeManagerModules.example

      # Or modules exported from other flakes (such as nix-colors):
      # inputs.nix-colors.homeManagerModules.default

      # You can also split up your configuration and import pieces of it here:
      # ./nvim.nix
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "vboxusers"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;


  home-manager.users.${user} = { pkgs, ... }: {

    xdg.desktopEntries = {
      chrome-desktop = {
        name = "Google Chrome";
        genericName = "Web Browser";
        exec = "${pkgs.google-chrome}/bin/google-chrome-stable --force-device-scale-factor=2 %U";
        terminal = false;
        icon = "google-chrome";
        categories = [ "Application" "Network" "WebBrowser" ];
        mimeType = [ "text/html" "text/xml" ];
        actions = {
          "new-window" = {
            name = "New Window";
            exec = "${pkgs.google-chrome}/bin/google-chrome-stable --force-device-scale-factor=2";
          };
          "new-private-window" = {
            name = "New Incognito Window";
            exec = "${pkgs.google-chrome}/bin/google-chrome-stable --force-device-scale-factor=2 --incognito";
          };
        };
      };

    };
    
    # services.home-manager.autoUpgrade = {
    #   enable = true;
    #   frequency = "3days";
    # };

    manual = {
      # better eval time
      html.enable = false;
      manpages.enable = false;
      # json.enable = false;
    }; 

    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "23.05";
    };

    imports = [ 
      ../modules/home-manager/navi.nix
      ../modules/home-manager/helix.nix
      ../modules/home-manager/dunst.nix
      ../modules/home-manager/polybar/polybar.nix
      ../modules/home-manager/udiskie.nix
    ];

    programs = {
      home-manager.enable = true;

      bat = {
        enable = true;
        config = {
          tabs = "2";
        };
        extraPackages = with pkgs.bat-extras; [ 
          prettybat
          batdiff 
          batman 
          batgrep 
          batwatch 
        ];

      };

      btop.enable = true;

      eza = {
        enable = true;
        git = true;
        icons = "auto";
        extraOptions = [
          "--header"
          "--all"
          "--classify"
          "--group"
          "--group-directories-first"
        ];
      };

      gh = {
        enable = true;
        extensions = with pkgs; [
          gh-eco
          gh-cal
          gh-dash
          gh-actions-cache
          gh-markdown-preview
        ];
        # gitCredentialHelper.enable = true; # todo check and move
      };


      git = {
        enable = true;
        settings = {
        #  userName = { "borg1622"; };
        #  userEmail = { "github@dirk-osburg.de"; };
        };
      };
      delta = {
        enable = true;
        enableGitIntegration = true;
        options = {
          line-numbers = true;
          conflictstyle = "diff3";
          colorMoved = "default";
        };
      };

      gitui.enable = true;

      
      hstr.enable = true;

      # htop = {
      #   enable = true;
      #   settings = {
      #     color_scheme = 6; # was 0
      #     cpu_count_from_one = 1;
      #     delay = 15;
      #     fields = with config.lib.htop.fields; [
      #       PID
      #       USER
      #       PRIORITY
      #       NICE
      #       M_SIZE
      #       M_RESIDENT
      #       M_SHARE
      #       STATE
      #       PERCENT_CPU
      #       PERCENT_MEM
      #       TIME
      #       COMM
      #     ];
      #     enable_mouse = 1;
      #     highlight_base_name = 1;
      #     highlight_megabytes = 1;
      #     highlight_threads = 1;
      #     highlight_changes = 1;
      #     highlight_changes_delay_secs = 5;
      #     show_cpu_usage = 1;
      #     show_cpu_frequency = 1;
      #     show_thread_names = 1;
      #     tree_view = 1;
      #     tree_view_always_by_pid = 1;
      #   } // (with config.lib.htop; leftMeters [
      #     (bar "AllCPUs2")
      #     (bar "Memory")
      #     (bar "Swap")
      #     (text "Zram")
      #   ]) // (with config.lib.htop; rightMeters [
      #     (text "Tasks")
      #     (text "LoadAverage")
      #     (text "Uptime")
      #     (text "Systemd")
      #   ]);
      # };

      jq.enable = true;

      lazygit.enable = true;

      # mcfly = {
      #   enable = true;
      #   fuzzySearchFactor = 3;
      #   keyScheme = "vim";
        
      # };
      nix-index.enable = true;
      # xplr.enable = true;  # not yet included in 23.05 ToDo: activate in next home manager release


    };
        
  };
}
