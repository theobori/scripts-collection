# Paths
INSTALL_DIR=/usr/local/bin/
SRC = ./wall.sh

# Format the shell scripts to get a set with the full path
BINS=$(addprefix $(INSTALL_DIR),$(SRC))

makedir:
	test -d $(INSTALL_DIR) || mkdir -p $(INSTALL_DIR)
.PHONY: makedir

install-all: makedir \
	install-wall.sh
.PHONY: install-all

install-wall.sh: makedir
	install -m 0755 ./wall.sh $(INSTALL_DIR)
.PHONY: install-wall.sh


uninstall-all:
	@echo $(BINS)
.PHONY: uninstall-all
