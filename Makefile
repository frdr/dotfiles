.PHONY: install install_bash
install: install_bash

install_bash: bashrc bashrc.d/*
	cp bashrc ~/.bashrc
	mkdir -p ~/.bashrc.d
	cp bashrc.d/* ~/.bashrc.d/
	#cp bash_aliases ~/.bash_aliases
