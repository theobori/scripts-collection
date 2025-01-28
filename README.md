# Scripts collection

[![build](https://github.com/theobori/scripts-collection/actions/workflows/build.yml/badge.svg)](https://github.com/theobori/scripts-collection/actions/workflows/build.yml)

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repository contains some shell scripts I have made. Most of them are made for Bash. There are scripts for installing programs, games, utilities and even some designed to work with `i3blocks`.

## Getting started

Feel free to override `PREFIX_DIR` if needed with the Makefile.
For example you could install the scripts for the user only with the following command line.

```bash
PREFIX_DIR=~/.local/ make install
```

If you want to override the scripts that will be installed, feel free to edit the `INSTALL_SCRIPTS` target in the Makefile.

## Contribute

If you want to help the project, you can follow the guidelines in [CONTRIBUTING.md](./CONTRIBUTING.md).
