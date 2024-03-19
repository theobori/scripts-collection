PREFIX_DIR=/usr/local

# Symbolic links path
INSTALL_DIR = $(PREFIX_DIR)/bin

# Scripts path
OPT_DIR = $(PREFIX_DIR)/opt/scripts-collection
OPT_BIN = $(OPT_DIR)/bin
OPT_LIB = $(OPT_DIR)/lib

BINS = $(wildcard $(bin)/*)

# Scripts that are going to be installed into $(INSTALL_DIR)
INSTALL_SCRIPTS = sc-wall \
	sc-snake \
	sc-anonfile \
	sc-update_sc \
	sc-is_live \
	sc-docker_infos \
	sc-pomodoro \
	sc-timer \
	sc-colors \
	sc-capital

# Format the shell scripts to get a set with the full path
# $(LINKS) is only used to clean the symlinks
LINKS = $(addprefix $(INSTALL_DIR)/,$(INSTALL_SCRIPTS))

# Not using Bash string substitution to make it shell independant
INSTALL_SCRIPTS_DEST = $(foreach script, $(INSTALL_SCRIPTS), $(OPT_BIN)/$(script))

all: help

init:
	test -d $(INSTALL_DIR) || mkdir -p $(INSTALL_DIR)
	test -d $(OPT_BIN) || mkdir -p $(OPT_BIN)
	test -d $(OPT_LIB) || mkdir -p $(OPT_LIB)

install: init
	cp -r ./bin $(OPT_DIR)
	cp -r ./lib $(OPT_DIR)

	ln -sf $(INSTALL_SCRIPTS_DEST) $(INSTALL_DIR)

clean:
	$(RM) $(LINKS)

uninstall: clean
	$(RM) -r $(OPT_DIR)

re: uninstall install

help:
	@echo "scripts-collection"
	@echo 
	@echo "Install the scripts"
	@echo 
	@echo "  * Installable scripts are listed in the README file"
	@echo "  * To install them, run the following command"
	@echo 
	@echo "    sudo make install"
	@echo 
	@echo "Uninstall the scripts"
	@echo 
	@echo "  * To uninstall them, run the following command"
	@echo 
	@echo "    sudo make uninstall"
	@echo 

.PHONY: init clean install uninstall re help
