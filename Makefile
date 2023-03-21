PREFIX_DIR=/usr/local

# Symbolic links path
INSTALL_DIR = $(PREFIX_DIR)/bin

# Scripts path
OPT_DIR = $(PREFIX_DIR)/opt/scripts-collection
OPT_BIN = $(OPT_DIR)/bin
OPT_LIB = $(OPT_DIR)/lib

# Format the shell scripts to get a set with the full path
# $(LINKS) is only used to clean the symlinks
BINS = $(wildcard bin/*)
LINKS = $(addprefix $(PREFIX_DIR)/,$(BINS))

all: help

init:
	test -d $(INSTALL_DIR) || mkdir -p $(INSTALL_DIR)
	test -d $(OPT_BIN) || mkdir -p $(OPT_BIN)
	test -d $(OPT_LIB) || mkdir -p $(OPT_LIB)

	cp -r ./bin $(OPT_DIR)
	cp -r ./lib $(OPT_DIR)

####################
# Install scripts
####################

func_link = test -h $(INSTALL_DIR)/$(1) || \
	ln -s $(OPT_BIN)/$(1) $(INSTALL_DIR)/$(1)

install: init
	$(call func_link,sc-wall)
	$(call func_link,sc-snake)
	$(call func_link,sc-anonfile)
	$(call func_link,sc-update_sc)
	$(call func_link,sc-is_live)
	$(call func_link,sc-docker_infos)
	$(call func_link,sc-pomodoro)
	$(call func_link,sc-timer)
	$(call func_link,sc-colors)
	$(call func_link,sc-capital)

####################
# Uninstall scripts
####################

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
	@echo "Test via Docker"
	@echo 
	@echo "     docker build -t scripts-playground ."
	@echo "     docker run -it scripts-playground"
	@echo 
	@echo "Uninstall the scripts"
	@echo "  * To uninstall them, run the following command"
	@echo 
	@echo "    sudo make uninstall"
	@echo 

.PHONY: init clean install uninstall re help
