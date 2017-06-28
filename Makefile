.PHONY: install
install: install_inputrc install_xsessionrc install_bash

install_inputrc: inputrc
	cp inputrc ~/.inputrc

install_xsessionrc: xsessionrc
	cp xsessionrc ~/.xsessionrc

install_bash: bashrc more_bashrc bash_aliases
	cp bashrc ~/.bashrc
	cp more_bashrc ~/.more_bashrc
	cp bash_aliases ~/.bash_aliases
