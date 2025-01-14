{ pkgs, ... }:

{

  programs.kitty = {
    enable = true;
    extraConfig = ''
      include theme.conf
    '';
    font = {
      name = "Iosevka Term";
      package = (pkgs.nerdfonts.override { withFont = "Iosevka"; });
    };
    keybindings = {
      "kitty_mod+enter" = "new_window_with_cwd";
      "kitty_mod+k" = ''
        combine : clear_terminal scrollback active : send_text normal \x0c
      '';
    };
    settings = {
      editor = ''emacsclient -nw -a ""'';
      font_size = 24;
      kitty_mod = "ctrl+shift";
      scrollback_lines = -1;
      shell = ".";
      term = "xterm";
    };
  };

  xdg.configFile."kitty/theme.conf".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/dexpota/kitty-themes/c4bee86ce8372d3426620e27086d6afa6873a98c/themes/Solarized_Dark.conf";
    sha256 = "0vwjcyd0asqrbs4437k2b80lqlanl79q03kk4pjnfdf379jklrm4";
  };

}
