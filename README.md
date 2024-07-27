# Scripts collection

This repository contains some shell scripts I have made. Most of them are made for Bash.

## 📖 How to build and run ?

1. Install the dependencies
    - `bash>=4.0` (or at least a shell supporting bash)
    - Basic Linux binaries
    - `figlet`

2. Run `make` to get informations

Feel free to override `PREFIX_DIR` if needed.

For example you could install the scripts for the user only with the following command line.

```bash
PREFIX_DIR=~/.local/ make install
```

## 🤝 Contribute

If you want to help the project, you can follow the guidelines in [CONTRIBUTING.md](./CONTRIBUTING.md).

## ℹ️ Scripts informations

Here are informations about the scripts.

Name            | Installable         | With permissions¹
:-------------   | :-------------: | :-------------:
`sc-wall` | ✅ | ❌
`sc-install_discord` | ❌ | ✅
`sc-install_terraform` | ❌ | ✅
`sc-install_tor` | ❌ | ✅
`sc-snake` | ✅ | ❌
`sc-fullrm_nix` | ❌ | ✅
`sc-docker_ps_len` | ✅ | ❌
`sc-pomodoro` | ✅ | ❌
`sc-timer` | ✅ | ❌
`sc-colors` | ✅ | ❌
`sc-capital` | ✅ | ❌
`sc-version` | ✅ | ❌

¹: *Most of the time when it required permission, it must be run as `root`*
