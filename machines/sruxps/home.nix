{ lib, pkgs, ... }:

{

  imports = [
    ../../config/bat.nix
    ../../config/browserpass.nix
    ../../config/bugwarrior.nix
    ../../config/direnv.nix
    ../../config/emacs
    ../../config/firefox.nix
    ../../config/fish
    ../../config/fzf.nix
    ../../config/git
    ../../config/gpg.nix
    ../../config/htop.nix
    ../../config/i3
    ../../config/jq.nix
    ../../config/kitty
    ../../config/man.nix
    ../../config/nixpkgs
    ../../config/rebar3.nix
    ../../config/taskwarrior
    # TODO: ../../config/vim.nix
  ];

  accounts.email.accounts.primary = {
    gpg.key = "EFD6F1EDC84D2FA935E38570462054AB8B682702";
    primary = true;
  };

  home.packages = with pkgs; ([
    aws-iam-authenticator
    ec2instanceconnectcli
    # dhall
    # dhall-json
    # docker-compose
    ghc
    jdk
    naal
    networkmanager-openconnect
    # next
    openconnect
    pavucontrol
    renderizer
    zoom-us
  ] ++ (with nodePackages; [
    aws-azure-login
  ]));

  _module.args.pkgs = lib.mkForce pkgs;

}
