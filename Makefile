machine   ?= sruxps
nixos_dir ?= /etc/nixos

stow_flags := -R
ifneq (,$(findstring trace,$(MAKEFLAGS)))
stow_flags += -v
endif
stow = stow ${stow_flags}


.PHONY: stow
stow: .stow-local-ignore
	@ sudo ${stow} -t ${nixos_dir} .
	@ sudo ${stow} -t ${nixos_dir} -d machines ${machine}
	@ mkdir -p ~/.config/cachix
	@ ${stow} -t ~/.config/cachix cachix


.PHONY: .envrc
.envrc:
	@ echo 'export profile=${profile}' >$@
	@ direnv allow


.PHONY: .stow-local-ignore
.stow-local-ignore:
	@ ls -A1 | sed '/^\(config\|modules\|overlays\)$$/d' >$@


.PHONY: build dry-build switch
build dry-build switch: stow
	@ sudo nixos-rebuild $@
