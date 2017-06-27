.PHONY: install
install: ~/.inputrc ~/.xsessionrc

~/.inputrc: inputrc
	cp inputrc ~/.inputrc

~/.xsessionrc: xsessionrc
	cp xsessionrc ~/.xsessionrc
