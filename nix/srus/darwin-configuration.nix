{ config, lib, pkgs, ... }:

with import ./srcs;

{
  imports = [
    ./config/applications.nix
    ./config/beam.nix
    ./config/dhall.nix
    ./config/gap.nix
    ./config/git.nix
    ./config/haskell.nix
    ./config/java.nix
    ./config/node-packages.nix
    ./config/node.nix
    ./config/k8s.nix
    ./config/shell.nix
    ./config/system-defaults.nix
  ];

  environment.systemPackages = (with pkgs; [
    aspell
    aspellDicts.en
    emacs
    gcc
    graphviz
    ncurses
    nix
    nix-prefetch-git
    pandoc
    pcre
    python
    python3
    vim
    zlib
    ]) ++ (with pkgs.python27Packages; [
      pywatchman
    ]) ++ (with pkgs.python35Packages; [
      pygments
    ]);

  # Recreate /run/current-system symlink after boot.
  services.activate-system.enable = true;

  services.nix-daemon = {
    enable = true;
    tempDir = "/nix/tmp";
  };

  environment.pathsToLink =
    [ # "/bin"
      "/lib/aspell"
      # "/share/info"
      # "/share/locale"
      "/share/emacs"
      # "/Applications"
    ];

  nix = {

    binaryCaches = [
      # "https://cache.nixos.org"
      "https://yurrriq-nur-packages.cachix.org"
    ];

    binaryCachePublicKeys = [
      # "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "yurrriq-nur-packages.cachix.org-1:7kbjuGBUZcWf876g2cdelmIQXrXzOhpMVBqYOyyAv70="
    ];

    buildCores = 8;

    # TODO: buildMachines = [];

    distributedBuilds = false;

    gc.automatic = true;

    maxJobs = 8;

    nixPath = [
      "darwin=$HOME/.nix-defexpr/channels/darwin"
      "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
      "nixpkgs=${_nixpkgs}"
    ];

  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import _nur {
      inherit pkgs;
    };
  };

}