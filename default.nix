{
  stdenv,
  libnotify,
  figlet,
  mlocate,
  curl,
  wget,
  gnupg,
  jq,
  unzip,
  desktop-file-utils,
  ncurses5,
  xdg-utils,
  bash,
}:
stdenv.mkDerivation {
  name = "scripts-collection";
  version = "0.2.0";
  src = ./.;

  buildInputs = [
    libnotify
    figlet
    mlocate
    curl
    wget
    gnupg
    jq
    unzip
    desktop-file-utils
    ncurses5
    xdg-utils
    bash
  ];

  installPhase = ''
    PREFIX_DIR=$out make install
  '';
}
