PREFIX_DIR=/usr/local

# Symbolic links path
INSTALL_DIR = $(PREFIX_DIR)/bin

# Scripts path
OPT_DIR = $(PREFIX_DIR)/opt/scripts-collection

# Executable scripts
SRC = $(wildcard *.sh)

# Format the shell scripts to get a set with the full path
LINKS = $(addprefix $(INSTALL_DIR)/,$(SRC))
SCRIPTS = $(addprefix $(OPT_DIR)/,$(SRC))

all: help

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
	$(call func_link,snake.sh)
	$(call func_link,anonfile.sh)
	$(call func_link,update_sc.sh)

####################
# Uninstall scripts
####################

clean:
	$(RM) $(LINKS)

uninstall: clean
	$(RM) $(SCRIPTS)
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

.PHONY: init clean install uninstall re help
