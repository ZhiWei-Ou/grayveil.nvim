NVIM ?= nvim

.PHONY: test
test:
	XDG_RUNTIME_DIR=/tmp NVIM_LOG_FILE=/tmp/grayveil-nvim.log $(NVIM) --headless -u NONE -i NONE -l spec/colorscheme_spec.lua
