{ appimageTools, fetchurl, lib }:

let
  pname = "exiled-exchange";
  version = "0.14.0";

  src = fetchurl {
    url = "https://github.com/Kvan7/Exiled-Exchange-2/releases/download/v${version}/Exiled-Exchange-2-${version}.AppImage";
    sha256 = "0r9303hppdqsxi35qb2b90z7f54qhwcxx898ijviqyq5n2xbxrf1";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    libsecret
    libnotify
  ];

  meta = with lib; {
    description = "Trading and price-checking overlay for Path of Exile 2";
    homepage = "https://github.com/Kvan7/Exiled-Exchange-2";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "exiled-exchange";
  };
}
