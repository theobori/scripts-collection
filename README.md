# scripts-collection

Just random shell scripts, useful or not 

## How to build and run ?
1. Install the dependencies
    - `bash>=4.0` (or at least a shell supporting bash)
    - Basic Linux binaries

2. Run `make` to get informations


## How to uninstall ?
```bash
sudo make uninstall
```

## Docker playground

#### Build

```bash
docker build -t scripts-playground .
```
#### Run

```bash
docker run -it scripts-playground
```

## State

Name           | Status          | Install
:-------------  | :-------------: | :-------------:
**`wall.sh`** | ✅ | ✅
**`install_discord.sh`** | ✅ | ❌
**`install_tor.sh`** | ✅ | ❌
**`snake.sh`** | ✅ | ✅
**`anonfile.sh`** | ✅ | ✅
**`update_sc.sh`** | ✅ | ✅
**`fullrm_nix.sh`** | ✅ | ❌
**`docker_ps_len.sh`** | ✅ | ✅
