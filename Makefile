.PHONY: install
install: install_inputrc install_xsessionrc

install_inputrc: inputrc
	cp inputrc ~/.inputrc

install_xsessionrc: xsessionrc
	cp xsessionrc ~/.xsessionrc
