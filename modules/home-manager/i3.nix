{config, home, ...}:
{
  # #### This file is intended to be included by a home-manager configugration
  # #### -> home-manager.users.*.imports = [ "<thisfile>" ];
  xsession.windowManager.i3 = {
      enable = true;
      extraConfig = ''
      # 2023
        set $mod Mod4
        set $alt Mod1

        # Define names for default workspaces for which we configure key bindings later on.
        # We use variables to avoid repeating the names in multiple places.
        set $ws1 "1:www"
        set $ws2 "2:vvv"
        set $ws3 "3:Fui"
        set $ws4 "4:Fcmd"
        set $ws5 "5:vm-ctrl"
        set $ws6 "6:vm-guest"
        set $ws7 "7:mail"
        set $ws8 "8:rmt"
        set $ws9 "9:pwd"
        set $ws10 "10:mon"
        set $ws11 "11:cfg"
        set $ws12 "12:kdb"
        set $ws13 "13:dev"
        set $ws14 "14:gfx"
        set $ws15 "15"
        set $ws16 "16"
        set $ws17 "17"
        set $ws18 "18"
        set $ws19 "19"
        set $ws20 "20"
        set $ws21 "21"
        set $ws22 "22x"

        ## Volume control
          # Path to volume control, without trailing slash
          set $volumepath ${config.xdg.dataHome}/i3/i3-volume

          # Command for the status line
          #   ie: i3blocks, i3status
          set $statuscmd i3status

          # Signal used to update the status line
          #   i3blocks uses SIGRTMIN+10 by default
          #   i3status uses SIGUSR1 by default
          set $statussig SIGUSR1

          # Amount to increase/decrease volume as a percentage
          set $volumestep 5

        set $Locker /etc/i3/lock.sh && sleep 1
        set $Suspend /etc/i3/lock.sh -l && systemctl suspend

        # todo: refactor -> group together with corresponding mode and bindsym definition
        set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (F12) shutdown

        default_orientation auto

        bindsym --whole-window button9 exec --no-startup-id ".config/i3/mouse-toggle-scroll.sh"

        #for_window [class="Nm-connection-editor" instance="nm-connection-editor"] floating enable, move position mouse
        #for_window [class="(?i)^Gnome-calculator$" instance="(?i)^gnome-calculator$"] floating enable,border $defaultborder

        no_focus [window_role="pop-up"]
      '';

      config = {
        defaultWorkspace  = "$ws8";
        modifier          = "$mod";
        workspaceAutoBackAndForth = true;
        assigns = {
          "$ws1" = [{ window_role="^browser$"; class="(?i)^firefox$"; }];
          "$ws3" = [{ window_role="^fui-nautilus$"; }];
          "$ws4" = [{ window_role="^fcmd-ranger$"; }];
          "$ws5" = [{ class="^VirtualBox\ Manager$"; }];
          "$ws6" = [{ title="-\ Oracle\ VM\ VirtualBox$"; }];
          "$ws7" = [{ instance="(?i)^Mail$"; class="(?i)^Thunderbird$"; }];
          "$ws8" = [{ window_role="^rmt-local$"; }
                    { window_role="^rmt-3$"; }
                    { window_role="^rmt-3$"; }];
          "$ws9" = [{ class="(?i)^KeePassXC$"; title="(?i)^(?!Unlock\sDatabase).+$"; }];
          "$ws10" = [{ window_role="^mon-htop$"; }
                    { window_role="^mon-2$"; }
                    { window_role="^mon-3$"; }];
          "$ws11" = [{ window_role="^cfg-1$"; }
                    {window_role="^cfg-2$"; }];
          "$ws12" = [{ class="^Joplin$"; }];
          "$ws13" = [{ class="^Atom$"; }
                    { class="(?i)^vscodium$"; }
                    { class="^Gimp$"; }];
          "$ws21" = [{ window_role="(?i)^browser$"; class="(?i)^google-chrome$"; }];
          "$ws22" = [{ window_role="^browser$"; class="(?i)^firefox$"; title="\(Private\ Browsing\)$"; }];
        };

        floating = {
          modifier = "$mod";
          titlebar = true;
          criteria = [
            { instance="(?i)^Msgcompose$"; class="(?i)^Thunderbird$"; }
            { window_role="status-window|task_dialog|app|bubble|pop-up|page-info|Preferences"; }
            { class="Nm-connection-editor"; instance="nm-connection-editor"; }
            { class="(?i)^Gnome-calculator$"; instance="(?i)^gnome-calculator$"; }
            { class="^pavucontrol$"; }
            { class="Xmessage"; }
          ];
        };

        window = {
          commands = [
            { command = "floating enable, move position mouse"; criteria = { class="Nm-connection-editor"; instance="nm-connection-editor"; } }
            { command = "floating enable,border $defaultborder"; criteria = { class="(?i)^Gnome-calculator$"; instance="(?i)^gnome-calculator$"; } }
            { command = "floating enable,border $defaultborder,sticky enable"; criteria = { class="(?i)^KeePassXC$"; title="(?i)^Unlock Database\s-\sKeePassXC$"; } }
          ];
        };

        focus = {
          mouseWarping = false;
          wrapping = "yes"; # maybe change to 'workspace' https://i3wm.org/docs/userguide.html#_focus_wrapping
        };

        fonts = {
          names = [ "DejaVu Sans Mono" ];   # maybe 'pango:DejaVu Sans Mono'
          size = 9.0;
        };

        startup = [
          { command = "systemctl --user restart polybar"; always = true; notification = false; }

          # todo: exec --no-startup-id autorandr
          { command = "xrandr --dpi 220"; always = false; notification  = false; }
          
          # todo: check if this is necessary with home-manager module
            # run the daemon on i3 startup
            # it's necessary to keep the history of workspaces
            # store 5 last active workspaces in the history
          { command = "$ws --daemon --size 5"; always = false; notification  = false; }
          
          # The combination of xss-lock, nm-applet and pactl is a popular choice, so
          # they are included herVe as an example. Modify as you see fit.
          # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
          # screen before suspend. Use loginctl lock-session to lock your screen.
          { command = "xss-lock --transfer-sleep-lock -- i3lock --nofork"; always = false; notification = false; }

          # NetworkManager is the most popular way to manage wireless networks on Linux,
          # and nm-applet is a desktop environment-independent system tray GUI for it.
          { command = "nm-applet &"; always = true; notification = false; }
          # 
          #{ command = "udiskie -t & "; always = false; notification = false; }
          # 
          { command = "kinesis-init-keyboard"; always = true; notification = false; }
          # 
          { command = "${config.xdg.dataHome}/i3/i3-start-apps.sh"; always = false; notification = false; }
          # # 
          # { command = ""; always = false; notification = false; }
          # # 
          # { command = ""; always = false; notification = false; }

          # # 
          # { command = ""; always = false; notification = false; }
          # # 
          # { command = ""; always = false; notification = false; }
          # # 
          # { command = ""; always = false; notification = false; }
          # # 
          # { command = ""; always = false; notification = false; }

          #exec_always --no-startup-id pavucontrol & 
          #exec-always --no-startup-id "xmodmap ~/.Xmodmap &"
          #exec --no-startup-id /usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

        ];

        # we will define keybindings from the scratch in order to disable default bindings and avoid conflicts with rebinds
        keybindings = {
          # currently not implemented
            # Use pactl to adjust volume in PulseAudio.
              #bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
              #bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
              #bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
              #bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status
            # Keepass global auto type
              #bindsym --release $mod+Shift+a  exec mono /usr/lib/keepass2/KeePass.exe --auto-type
            # Texpander
              #bindsym --release Ctrl+space exec ~/bin/texpander.zsh
            # dmenu
              # start dmenu (a program launcher)
              # bindsym $mod+d exec dmenu_run
              # There also is the (new) i3-dmenu-desktop which only displays applications
              # shipping a .desktop file. It is a wrapper around dmenu, so you need that
              # installed.
              # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

          # system control
            # suspend/hibernate/etc
              "$mod+l"              = "exec --no-startup-id $Locker";  # todo: rewrite variable, use nix variable instead
              "$alt+Control+Delete" = "exec --no-startup-id $Suspend"; # todo: rewrite variable, use nix variable instead
              # todo: refactor -> group together with corresponding mode and set definition
              "$mod+Pause"          = "mode \"$mode_system\"";
              "$mod+Shift+e"        = "mode \"$mode_system\""; 

          # i3 control    
            # reload the configuration file
              "$mod+Shift+c"      = "reload";
            # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
              "$mod+Shift+r"      = "restart";

          # Application control
            # start a terminal
              "$mod+Return"       = "exec i3-sensible-terminal";
            # kill focused window
              "$mod+Shift+q"      = "kill";

          # Workspace control
            # change focus
              "$mod+Left"         = "focus left";
              "$mod+Down"         = "focus down";
              "$mod+Up"           = "focus up";
              "$mod+Right"        = "focus right";
            # move focused window
              "$mod+Shift+Left"   = "move left";
              "$mod+Shift+Down"   = "move down";
              "$mod+Shift+Up"     = "move up";
              "$mod+Shift+Right"  = "move right";
            # Moving workspace between screens
              "$mod+Shift+p"      = "move workspace to output right";
            # split in horizontal orientation
              "$mod+h"            = "split h";
            # split in vertical orientation
              "$mod+v"            = "split v";
            # enter fullscreen mode for the focused container
              "$mod+f"            = "fullscreen toggle";
            # change container layout (stacked, tabbed, toggle split)
              "$mod+Ctrl+s"       = "layout stacking";
              "$mod+Ctrl+w"       = "layout tabbed";
              "$mod+Ctrl+e"       = "layout toggle split";
            # toggle tiling / floating
              "$mod+Shift+space"  = "floating toggle";
            # change focus between tiling / floating windows
              "$mod+space"        = "focus mode_toggle";
            # focus the parent container
              "$mod+a"            = "focus parent";

            # resize container   todo: refactor -> group together with corresponding mode definition
              "$mod+r"            = "mode \"resize\"";

            # switch to" = "workspace
               "$mod+1"           = "workspace number $ws1";
               "$mod+2"           = "workspace number $ws2";
               "$mod+3"           = "workspace number $ws3";
               "$mod+4"           = "workspace number $ws4";
               "$mod+5"           = "workspace number $ws5";
               "$mod+6"           = "workspace number $ws6";
               "$mod+7"           = "workspace number $ws7";
               "$mod+8"           = "workspace number $ws8";
               "$mod+9"           = "workspace number $ws9";
               "$mod+0"           = "workspace number $ws10";
               "$mod+F1"          = "workspace number $ws11";
               "$mod+F2"          = "workspace number $ws12";
               "$mod+F3"          = "workspace number $ws13";
               "$mod+F4"          = "workspace number $ws14";
               "$mod+F5"          = "workspace number $ws15";
               "$mod+F6"          = "workspace number $ws16";
               "$mod+F7"          = "workspace number $ws17";
               "$mod+F8"          = "workspace number $ws18";
               "$mod+F9"          = "workspace number $ws19";
               "$mod+F10"         = "workspace number $ws20";
               "$mod+F11"         = "workspace number $ws21";
               "$mod+F12"         = "workspace number $ws22";

            # move focused container to workspace
               "$mod+Shift+1"     = "move container to workspace number $ws1";
               "$mod+Shift+2"     = "move container to workspace number $ws2";
               "$mod+Shift+3"     = "move container to workspace number $ws3";
               "$mod+Shift+4"     = "move container to workspace number $ws4";
               "$mod+Shift+5"     = "move container to workspace number $ws5";
               "$mod+Shift+6"     = "move container to workspace number $ws6";
               "$mod+Shift+7"     = "move container to workspace number $ws7";
               "$mod+Shift+8"     = "move container to workspace number $ws8";
               "$mod+Shift+9"     = "move container to workspace number $ws9";
               "$mod+Shift+0"     = "move container to workspace number $ws10";
               "$mod+Shift+F1"    = "move container to workspace number $ws11";
               "$mod+Shift+F2"    = "move container to workspace number $ws12";
               "$mod+Shift+F3"    = "move container to workspace number $ws13";
               "$mod+Shift+F4"    = "move container to workspace number $ws14";
               "$mod+Shift+F5"    = "move container to workspace number $ws15";
               "$mod+Shift+F6"    = "move container to workspace number $ws16";
               "$mod+Shift+F7"    = "move container to workspace number $ws17";
               "$mod+Shift+F8"    = "move container to workspace number $ws18";
               "$mod+Shift+F9"    = "move container to workspace number $ws19";
               "$mod+Shift+F10"   = "move container to workspace number $ws20";
               "$mod+Shift+F11"   = "move container to workspace number $ws21";
               "$mod+Shift+F12"   = "move container to workspace number $ws22";

          # Notifications
            # dunst
              "$mod+grave"            = "exec --no-startup-id dunstctl history-pop";
              "$mod+Shift+Period"     = "exec --no-startup-id dunstctl context";  # todo: fix / check
              "$mod+BackSpace"        = "exec --no-startup-id dunstctl close";
              "$mod+Shift+BackSpace"  = "exec --no-startup-id dunstctl close-all";

          # Menu
            # rofi
              "$mod+d"              = ''exec "rofi -dpi 0 -combi-modi window,ssh,drun,run -show combi -modi combi,window,drun,ssh"'';
              "$mod+w"              = ''exec "rofi -dpi 0 -show window"'';
              # todo" replace calc by NixOS variable path
              "$mod+c"              = ''exec "rofi -dpi 0 -show calc -modi calc -no-show-match -no-bold -no-sort -hint-welcome \\"Calculator - copy result to clipboard: <ctrl> + <enter>\\" -calc-command \\"echo -n '{result}' | xsel --clipboard\\""'';

          # Audio  # todo: define i3 variables
            # pulseaudio-utils settings
            #
            # Symbolic name for sink (numeric index not supported)
            #   Recommended: comment out this setting and omit the -s option to use default sink
            #   List sink names: pacmd list-sinks | awk -F "[<>]" '/^\s+name: <.*>/{print $2}'
            # set $sinkname alsa_output.pci-0000_00_1b.0.analog-stereo
            # Using pulseaudio-utils (append "-s $sinkname" without quotes to override default sink)
            "XF86AudioRaiseVolume"  = "exec $volumepath -np -i $volumestep -t $statuscmd -u $statussig";
            "XF86AudioLowerVolume"  = "exec $volumepath -np -d $volumestep -t $statuscmd -u $statussig";
            "XF86AudioMute"         = "exec $volumepath -mn -t $statuscmd -u $statussig";

          # Display brightness
            "XF86MonBrightnessUp"   = "exec --no-startup-id 'xbacklight -inc 5'";
            "XF86MonBrightnessDown" = "exec --no-startup-id 'xbacklight -dec 5'";            

          # Screenshots
            #Screenshot of active/focused window
            "Ctrl+Print"  = "exec scrot -q 1 -u '%Y%m%d_%H%M%S.png' -e 'mv $f ~/Pictures/scrot/'";  # todo: adjust path using variable
            #Screenshot of whole screen
            "Print"       = "exec scrot -q 1 '%Y%m%d_%H%M%S.png' -e 'mv $f ~/Pictures/scrot/'";   # todo: adjust path using variable
            #Screenshot with selectable area
            "$mod+Print"  = "exec scrot -u '%Y%m%d_%H%M%S.png' -e 'mv $f ~/Pictures/scrot/' --release"; # todo: adjust path using variable
        };

        modes = {
          "resize" = {  # todo: refactor -> group together with corresponding bindsym definition
            # These bindings trigger as soon as you enter the resize mode
            # Pressing left will shrink the window’s width.
              "Left"    = "resize shrink width 10 px or 10 ppt";
            # Pressing right will grow the window’s width.
              "Down"    = "resize grow height 10 px or 10 ppt";
            # Pressing up will shrink the window’s height.
              "Up"      = "Up resize shrink height 10 px or 10 ppt";
            # Pressing down will grow the window’s height.
              "Right"   = "Right resize grow width 10 px or 10 ppt";

            # back to normal: Enter or Escape or $mod+r
              "Return"  = "mode default";
              "Escape"  = "mode default";
              "$mod+r"  = "mode default";
          };

          "$mode_system" = {  # todo: refactor -> group together with corresponding bindsym and set definition
            "l"       = "exec --no-startup-id $Locker, mode default";
            "e"       = "exec --no-startup-id autorandr -l Mobile-UHD && i3-msg exit, mode default";   # todo: refactoring
            "s"       = "exec --no-startup-id $Suspend, mode default";
            "h"       = "exec --no-startup-id $Locker && systemctl hibernate, mode default";
            "r"       = "exec --no-startup-id systemctl reboot, mode default";
            "F12"     = "exec --no-startup-id systemctl poweroff -p, mode default";

            #back to normal: Enter or Escape
            "Return"  = "mode default";
            "Escape"  = "mode default";
          };
        };

        workspaceOutputAssign = [
          # bind workspaces to screens >> https://i3wm.org/docs/userguide.html#workspace_screen
          # i3-msg -t get_outputs
          # Lenovo X230
          # { workspace = "$ws1";   output = [ "DP-2" "LVDS-1" ]; }
          # { workspace = "$ws2";   output = [ "DP-2" "LVDS-1" ]; }
          # { workspace = "$ws3";   output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws5";   output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws6";   output = [ "DP-2" "LVDS-1" ]; }
          # { workspace = "$ws7";   output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws8";   output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws9";   output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws10";  output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws11";  output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws12";  output = [ "DP-2" "LVDS-1" ]; }
          # { workspace = "$ws13";  output = [ "DP-2" "LVDS-1" ]; }
          # { workspace = "$ws14";  output = [ "DP-2" "LVDS-1" ]; }
          # { workspace = "$ws21";  output = [ "HDMI-3" "LVDS-1" ]; }
          # { workspace = "$ws22";  output = [ "HDMI-3" "LVDS-1" ]; }

          # Lenovo P14s
          { workspace = "$ws1";   output = [ "DP-2"   "eDP-1" ]; }
          { workspace = "$ws2";   output = [ "DP-2"   "eDP-1" ]; }
          { workspace = "$ws3";   output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws5";   output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws6";   output = [ "DP-2"   "eDP-1" ]; }
          { workspace = "$ws7";   output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws8";   output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws9";   output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws10";  output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws11";  output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws12";  output = [ "DP-2"   "eDP-1" ]; }
          { workspace = "$ws13";  output = [ "DP-2"   "eDP-1" ]; }
          { workspace = "$ws14";  output = [ "DP-2"   "eDP-1" ]; }
          { workspace = "$ws21";  output = [ "HDMI-3" "eDP-1" ]; }
          { workspace = "$ws22";  output = [ "HDMI-3" "eDP-1" ]; }
        ];

        colors = {
          background = "#FFFFFF";
          focused = {
            background  = "#244C6B";
            border      = "#4C7899";
            childBorder = "#244C6B";
            indicator   = "#57967A";
            text        = "#FFFFFF";
          };
          focusedInactive = {
            background  = "#52595B";
            border      = "#333333";
            childBorder = "#5F676A";
            indicator   = "#484E50";
            text        = "#D8D8D8";
          };
          placeholder = {
            background  = "#0C0C0C";
            border      = "#000000";
            childBorder = "#0C0C0C";
            indicator   = "#000000";
            text        = "#FFFFFF";
          };
          unfocused = {
            background  = "#222222";
            border      = "#333333";
            childBorder = "#222222";
            indicator   = "#292d2e";
            text        = "#888888";
          };
          urgent = {
            background  = "#900000";
            border      = "#2F343A";
            childBorder = "#900000";
            indicator   = "#900000";
            text        = "#FFFFFF";
          };

        };
      };      
   };

  # Ressources
    # file definitions
    xdg.dataFile."i3/lock.sh" = {
      executable = true;
      text = ''
          #!/bin/sh

          BLANK="000000"

          echo "''${BLANK}"
          i3params="\
            --image ${config.xdg.dataHome}/i3/bsod.png  \
            --color=''${BLANK}        \
            --blur 10                 \
            --no-unlock-indicator     \
            "

          while getopts l: flag
          do
            case "''${flag}" in
              s) SUSPEND='1' ;;
            esac
          done

          if [ -n ''${SUSPEND} ]
          then
            echo "SUSPEND"
            i3lock ''${i3params}
          else            
            trap "dunstctl set-paused false" EXIT
            dunstctl set-paused true
            echo "i3lock ''${i3params} --nofork"
            i3lock ''${i3params} --nofork
          fi
      '';
    };

    # directories
    xdg.dataFile."i3/layouts" = {
      source = ../lib/i3/ws-layouts;
      recursive = true;
    };

    # executable files
    xdg.dataFile."i3/i3-volume" = {
      executable = true;
      source = ../../lib/i3-volume/volume;
    };
    xdg.dataFile."i3/i3-start-apps.sh" = {
      executable = true;
      source = ../../lib/i3/i3-start-apps.sh;
    };

    # other non-executables
    xdg.dataFile."i3/bsod.png".source = ../lib/etc/bsod-2.png;
}