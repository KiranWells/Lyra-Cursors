{ stdenv
, lib
, inkscape
, xcursorgen
, styles ? [
    "LyraB"
    "LyraF"
    "LyraG"
    "LyraP"
    "LyraQ"
    "LyraR"
    "LyraS"
    "LyraX"
    "LyraY"
  ]
}: stdenv.mkDerivation {
  name = "lyra-cursors";
  src = ../.;

  nativeBuildInputs = [ inkscape xcursorgen ];

  dontConfigure = true;

  postPatch = ''
    patchShebangs ./build.sh
  '';

  buildPhase = ''
    for THEME in ${lib.escapeShellArgs styles}; do
      ./build.sh $THEME
    done
  '';

  installPhase = ''
    mkdir -p $out/share/icons
    mv dist/*-cursors $out/share/icons
  '';

  meta = {
    description = "The Lyra cursor theme";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
