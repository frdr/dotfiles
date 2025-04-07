.PHONY: help
help:
	@echo "use the \"install\" target to copy config files into your user's home."
	@echo "existing files will be overwritten."
	@echo "the \"clean\" target will delete your ~/.bashrc - use with caution."

.PHONY: install
install: install_bash link_dotfiles git_ignore

~/.bashrc: dot/bashrc
	cp bashrc ~/.bashrc

~/.bashrc.d:
	mkdir -p ~/.bashrc.d

~/.bashrc.d/%.sh: bashrc.d/%.sh ~/.bashrc.d
	cp $< $@

_user := $(shell whoami)
_hostname := $(shell hostname)
~/.bashrc.d/prompt.sh: bashrc.d/prompt.sh ~/.bashrc.d
	sed -e "s/\$${_bashrc_d_install_user:-}/$(_user)/" \
		-e "s/\$${_bashrc_d_install_host:-}/$(_hostname)/" < $< > $@

~/.%: dot/%
	ln --symbolic --relative $< $@

.PHONY: install_bash
install_bash: ~/.bashrc.d \
	~/.bashrc.d/0options.sh \
	~/.bashrc.d/browser.sh \
	~/.bashrc.d/exports.sh \
	~/.bashrc.d/nocaps.sh \
	~/.bashrc.d/prompt.sh

.PHONY: link_dotfiles
link_dotfiles: ~/.editorconfig ~/.bashrc

_gitignore := ~/.config/git/ignore
_ignore_pat := '.*.sw[po]'
.PHONY: git_ignore
git_ignore: $(gitignore)
	mkdir -p `basename $(_gitignore)`
	touch $(_gitignore)
	grep --quiet --fixed-strings $(_ignore_pat) $(_gitignore) || \
		echo $(_ignore_pat) >> $(_gitignore)

.PHONY: clean
clean:
	rm -rf ~/.bashrc.d
	rm -f ~/.bashrc
	rm -f ~/.editorconfig
