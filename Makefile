PREFIX_DIR=/usr/local

# Symbolic links path
INSTALL_DIR = $(PREFIX_DIR)/bin

# Scripts path
OPT_DIR = $(PREFIX_DIR)/opt/shell-collection

# Executable scripts
SRC = $(wildcard *.sh)

# Format the shell scripts to get a set with the full path
LINKS = $(addprefix $(INSTALL_DIR)/,$(SRC))
SCRIPTS = $(addprefix $(OPT_DIR)/,$(SRC))

init:
	test -d $(INSTALL_DIR) || mkdir -p $(INSTALL_DIR)
	test -d $(OPT_DIR) || mkdir -p $(OPT_DIR)

	cp -r $(SRC) $(OPT_DIR)

####################
# Install scripts
####################

func_link = test -h $(INSTALL_DIR)/$(1) || \
	ln -s $(OPT_DIR)/$(1) $(INSTALL_DIR)/$(1)

install: init
	$(call func_link,wall.sh)

####################
# Uninstall scripts
####################

clean:
	$(RM) $(LINKS)

uninstall: clean
	$(RM) $(SCRIPTS)

.PHONY: init clean install uninstall
