{ lib, pkgs, ... }:

{

  programs.fish = let inherit (lib.strings) fileContents; in {
    enable = true;

    interactiveShellInit = fileContents ./fish/interactiveShellInit.fish;

    promptInit = ''
      ${fileContents ./fish/sushi/fish_prompt.fish}

      ${fileContents ./fish/sushi/fish_right_prompt.fish}
    '';

    shellAliases = rec {
      # ag = rgs;
      # agn = rgn; # "ag --nogroup";
      # agq = rgf; # "ag -Q";

      e = "emacsclient -na \"\"";
      ec = e + " -c";
      et = "emacsclient -nw -a \"\"";

      gpg = "gpg2";

      k = "clear";

      l = "ls -Glah";
      ll = "ls -Glh";
      ls = "ls -G";

      # nb = "nix build -f '<nixpkgs>' --no-link";
    };

    shellAbbrs = rec {
      # Git
      g = "git";
      gd = "${g} d";
      gdc = "${g} dc";
      gs = "${g} st";

      # Kubernetes
      kc = "kubectl";
      kt = "kubetail";

      # ripgrep
      rga = "rg --hidden --iglob !.git";
      rgf = "rg -F";
      rgi = "rg -i";
      rgn = "rg --no-heading";
      rgs = "rg -S";

      # Taskwarrior
      p = "task list";
      pp = tbd;
      t = "task";
      ta = "task add";
      tbd = "task burndown.daily";
      te = "env VISUAL=$EDITOR task edit";
      tm = "task mod";
    };

    shellInit = fileContents ./fish/shellInit.fish;
  };

}
