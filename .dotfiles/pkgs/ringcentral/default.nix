{ appimageTools, fetchurl, lib }:

let
  pname = "ringcentral-embeddable";
  version = "0.5.1";

  src = fetchurl {
    url = "https://github.com/ringcentral/ringcentral-embeddable-electron-app/releases/download/v${version}/RingCentral.Embeddable-${version}.AppImage";
    sha256 = "0qpkyqsmq2yyrivdgm825gffnh1v2y4pwsfmvccqj7yym7qnssb6";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs = pkgs: with pkgs; [
    libsecret
    libnotify
  ];

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cat > $out/share/applications/${pname}.desktop <<EOF
[Desktop Entry]
Name=RingCentral Embeddable
Exec=$out/bin/${pname}
Icon=ringcentral
Type=Application
Categories=Network;Chat;
EOF
  '';

  meta = with lib; {
    description = "RingCentral Embeddable Electron App";
    homepage = "https://github.com/ringcentral/ringcentral-embeddable-electron-app";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    mainProgram = "ringcentral-embeddable";
  };
}
