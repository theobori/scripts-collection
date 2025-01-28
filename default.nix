{
  pkgs,
  stdenv,
  lib,
  makeWrapper,
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
}@inputs:
let
  inherit (lib)
    filter
    attrNames
    map
    elem
    ;

  deps =
    let
      exclude = [
        "stdenv"
        "lib"
        "makeWrapper"
        "pkgs"
      ];
      names = attrNames inputs;
      filteredNames = filter (n: !(elem n exclude)) names;
    in
    map (n: pkgs.${n}) filteredNames;
in
stdenv.mkDerivation {
  name = "scripts-collection";
  version = "0.2.0";
  src = ./.;

  nativeBuildInputs = [ makeWrapper ];

  passthru = {
    devPackages = deps;
  };

  installPhase = ''
    runHook preInstall

    PREFIX_DIR=$out make install

    for app in $out/bin/*; do
      wrapProgram "$app" \
        --prefix PATH : ${lib.makeBinPath deps}
    done

    runHook postInstall
  '';
}
