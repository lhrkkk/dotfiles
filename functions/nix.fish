# Lifted from:
# https://github.com/chris-martin/home/blob/7231bb1dea9744315360b676abab1b263d6bd706/nix/shell/nix.fish


#-------------------------------------------------------------------
#  The great nix function
#-------------------------------------------------------------------

function nix
  switch $argv[1]

    case rebuild-os
      sudo env NIX_PATH=$NIXOS_PATH nixos-rebuild switch

        case packages
          nix-env -q

        case install
          nix-env -f '<nixpkgs>' -iA $argv[2]

        case uninstall remove
          nix-env -f '<nixpkgs>' -e $argv[2]

        case shell
          nix-shell $argv[2..-1]

        case build
          nix-build $argv[2..-1]

        case path
          nix-store -r (nix drv $argv[2])

        case drv
          nix-instantiate '<nixpkgs>' -A $argv[2]

          # To manually walk through the build process for some package
        case debug
          cd (mktemp -d)
          nix-shell '<nixpkgs>' -A $argv[2] --pure

        case gc
          nix-collect-garbage --delete-older-than $argv[2]

        case optimise optimize
          nix-store --optimise

        case '*'
          echo "???"

      end
  end


  #-------------------------------------------------------------------
#  Tab completion for the nix function
#-------------------------------------------------------------------

function __fish_nix_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  else
    return 1
  end
end

complete -f -c nix -a rebuild-os \
  -n __fish_nix_needs_command \
  -d "Rebuild NixOS"

complete -f -c nix -a packages \
  -n __fish_nix_needs_command \
  -d "List installed packages"

complete -f -c nix -a install \
  -n __fish_nix_needs_command \
  -d "Install a package"

complete -f -c nix -a uninstall \
  -n __fish_nix_needs_command \
  -d "Uninstall a package"

complete -f -c nix -a shell \
  -n __fish_nix_needs_command \
  -d "Run nix-shell"

complete -f -c nix -a build \
  -n __fish_nix_needs_command \
  -d "Run nix-build"

complete -f -c nix -a path \
  -n __fish_nix_needs_command \
  -d "Find a package in /nix/store"

complete -f -c nix -a drv \
  -n __fish_nix_needs_command \
  -d "Find a derivation in /nix/store"

complete -f -c nix -a debug \
  -n __fish_nix_needs_command \
  -d "Step through a build"

complete -f -c nix -a gc \
  -n __fish_nix_needs_command \
  -d "Garbage collection on /nix/store"

complete -f -c nix -a optimise \
  -n __fish_nix_needs_command \
  -d "Reduce disk space usage"
