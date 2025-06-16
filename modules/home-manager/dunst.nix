{config, home, ...}:
{
  # #### This file is intended to be included by a home-manager configugration
  # #### -> home-manager.users.*.imports = [ "<thisfile>" ];
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "mouse";
        enable_posix_regex = "true";
        notification_limit = "3";
        history_length = "20";
        mouse_left_click = "do_action";
        mouse_right_click = "context";
        ignore_dbusclose = "true";
        
        dmenu = "/run/current-system/sw/bin/dmenu";       # todo: replace by nixOS expression # todo: replace by rofi - https://git.spritsail.io/frebib/dotfiles/commit/fc89b6359bfb5d34a901e26520256e2bd43cf47d
        browser = "/run/current-system/sw/bin/xdg-open";  # todo: replace by nixOS expression

        width = "(500,1000)";
        height = "200";
        origin = "bottom-center";
        offset = "0x30";

        transparency = "15"; # X11 only -> in wayland transparency is part of color definition

        frame_width = "1";
        frame_color = "#eceff1";
        corner_radius = "10";

        #font = "Droid Sans 9";
        # old config
        font = "Monospace 10";

        # The format of the message. Possible variables are:
        #   %a  appname
        #   %s  summary
        #   %b  body
        #   %i  iconname (including its path)
        #   %I  iconname (without its path)
        #   %p  progress value if set ([  0%] to [100%]) or nothing
        # Markup is allowed
        format = ''<b>%a</b>\n<i>%s</i>\n%b'';
 

        # split notifications into multiple lines if they don't fit into geometry
        word_wrap = "yes";

        # should a notification popped up from history be sticky or
        # timeout as if it would normally do.
        sticky_history = "yes";

        # The height of a single line. If the height is smaller than the font height,
        # it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = "8";

        # Draw a line of 'separatpr_height' pixel height between two notifications.
        # Set to 0 to disable
        separator_height = "1";

        # padding between text and separator
        padding = "8";

        # horizontal padding
        horizontal_padding = "8";

        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background
        #  * foreground: use the same color as the foreground
        #  * frame: use the same color as the frame.
        #  * anything else will be interpreted as a X color
        separator_color = "frame";

        # dmenu path
        # dmenu = "/usr/bin/dmenu -p dunst";

        # browser for opening urls in context menu
        # browser = /usr/bin/google-chrome


      };

      urgency_low = {
        timeout = "4s";

      };

      urgency_normal = {
        background = "#37474f";
        foreground = "#eceff1";
        timeout = "8s";

        # IMPORTANT: colors have to be defined in quotation marks.
        # Otherwise the '#' and following  would be interpreted as a comment.
        # background = "#222222";
        # foreground = "#888888";
        # timeout = "3";
      };

      urgency_critical = {
        timeout = "60s";
        background = "#900000";
        foreground = "#ffffff";
      };

      # [urgency_normal]
      #   background = "#285577"
      #   foreground = "#ffffff"
      #   timeout = 3

    };
  };

  # home-manager.users.${home.username} = { pkgs, ... }: {
  # https://github.com/denisidoro/navi/blob/master/docs/cheatsheet_syntax.md
    # xdg.dataFile."navi/cheats/dirk.cheat".text = ''
    #   % cat, dirk
    #   # bat: cat replacement, pretty print files
    #   bat 

    #   % cat, dirk
    #   # bat: cat replacement, pretty print binary files (with )non-printable characters like space, tab or newline
    #   bat -A --tabs <characters>
    #   '';

}