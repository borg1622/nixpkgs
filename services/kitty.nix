{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      kitty
    ];
    variables.TERMINAL = "kitty";

    etc = {
      "xdg/kitty/kitty.conf" = {
        text = ''
          clear_all_shortcuts yes

          foreground #aaaaaa

          font_family       monospace
          bold_font         auto
          italic_font       auto
          bold_italic_font  auto
          font_size 11.0

          cursor_stop_blinking_after 15.0

          scrollback_lines 100000
          mouse_hide_wait 3.0

          url_color #0087bd
          url_style curly

          open_url_modifiers kitty_mod
          open_url_with default

          url_prefixes http https file ftp

          select_by_word_characters @-./_~?&=%+#

          repaint_delay 20
          input_delay 10
          sync_to_monitor yes

          enable_audio_bell no
          visual_bell_duration 3.0
          bell_on_tab yes

          update_check_interval 0

          kitty_mod ctrl+shift
          map kitty_mod+c copy_to_clipboard
          map kitty_mod+v paste_from_clipboard

          map kitty_mod+plus change_font_size all +1.0
          map kitty_mod+minus change_font_size all -1.0
          map kitty_mod+0 change_font_size all 0

          map kitty_mod+up scroll_line_up
          map kitty_mod+k scroll_line_up
          map kitty_mod+down scroll_line_down
          map kitty_mod+j scroll_line_down
          map kitty_mod+page_up scroll_page_up
          map kitty_mod+page_down scroll_page_down
          map kitty_mod+home scroll_home
          map kitty_mod+end scroll_end
          map kitty_mod+h show_scrollback

          map kitty_mod+enter new_tab
          map kitty_mod+q close_tab
          map kitty_mod+right next_tab
          map kitty_mod+left previous_tab

        '';
      };
    };
  };
}
