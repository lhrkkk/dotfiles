{ ... }:

{

  xdg.configFile.kitty = {
    target = "kitty/kitty.conf";
    text = ''
      font_family Iosevka
      bold_font Iosevka Medium
      italic_font Iosevka Italic
      bold_italic_font Iosevka Medium Italic

      font_size 12.0
      scrollback_lines -1

      foreground #839496
      background #002b36

      color0  #073642
      color1  #dc322f
      color2  #859900
      color3  #b58900
      color4  #268bd2
      color5  #d33682
      color6  #2aa198
      color7  #eee8d5
      color8  #002b36
      color9  #cb4b16
      color10 #586e75
      color11 #657b83
      color12 #839496
      color13 #6c71c4
      color14 #93a1a1
      color15 #fdf6e3

      editor emacsclient -nw -a ""

      term xterm

      macos_option_as_alt yes

      kitty_mod ctrl+shift
      map kitty_mod+enter new_window_with_cwd

      map cmd+k combine : clear_terminal scrollback active : send_text normal \x0c
      map kitty_mod+k combine : clear_terminal scrollback active : send_text normal \x0c
    '';
  };

  xdg.configFile.kitty-diff = {
    target = "kitty/diff.conf";
    text = ''
      pygments_style monokai
    '';
  };
}
