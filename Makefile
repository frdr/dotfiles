_user := $(shell whoami)
_hostname := $(shell hostname)

.PHONY: help install install_bash link_dotfiles clean
help:
	@echo "use the \"install\" target to copy config files into your user's home."
	@echo "existing files will be overwritten."
	@echo "the \"clean\" target will delete you ~/.bashrc - use with caution."

install: install_bash link_dotfiles

~/.bashrc: bashrc
	cp bashrc ~/.bashrc

~/.bashrc.d:
	mkdir -p ~/.bashrc.d

~/.bashrc.d/%.sh: bashrc.d/%.sh ~/.bashrc.d
	cp $< $@

~/.bashrc.d/prompt.sh: bashrc.d/prompt.sh ~/.bashrc.d
	sed -e "s/\$${_bashrc_d_install_user:-}/$(_user)/" \
		-e "s/\$${_bashrc_d_install_host:-}/$(_hostname)/" < $< > $@

install_bash: ~/.bashrc \
	~/.bashrc.d/0options.sh \
	~/.bashrc.d/browser.sh \
	~/.bashrc.d/exports.sh \
	~/.bashrc.d/nocaps.sh \
	~/.bashrc.d/prompt.sh

~/.%: dot/%
	ln --symbolic --relative $< $@

link_dotfiles: ~/.editorconfig

clean:
	rm -rf ~/.bashrc.d
	rm -f ~/.bashrc
	rm -f ~/.editorconfig
