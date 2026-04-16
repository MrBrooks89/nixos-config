{ 
  stdenv, 
  fetchFromGitHub, 
  fetchYarnDeps, 
  electron, 
  nodejs, 
  yarn, 
  fixup-yarn-lock, 
  makeWrapper 
}:

let
  pname = "ringcentral-community-app";
  version = "0.0.12";

  src = fetchFromGitHub {
    owner = "ringcentral";
    repo = "ringcentral-community-app";
    rev = "v${version}";
    sha256 = "07s9vzkqna5br21vmp0vif0s6hvzap3i6ca2vplx7fc7r7d6npqd";
  };

  # 1. This creates a "fixed-output derivation" of all the yarn dependencies.
  # This is the secret to getting 'yarn install' to work offline in Nix.
  offlineCache = fetchYarnDeps {
    yarnLock = "${src}/yarn.lock";
    sha256 = "0xddwr9agsbvb8zbz1xi8pc2riym7wd44w5dj7i26l810g89a3sc";
  };

in stdenv.mkDerivation {
  inherit pname version src;

  nativeBuildInputs = [ 
    nodejs
    yarn
    fixup-yarn-lock
    makeWrapper
  ];

  buildInputs = [ 
    electron 
  ];

  configurePhase = ''
    export HOME=$PWD
    # Fixup the yarn.lock to be Nix-compatible
    fixup-yarn-lock yarn.lock
    # Tell yarn to use our offline cache
    yarn config --offline set yarn-offline-mirror ${offlineCache}
    # Install the dependencies offline
    yarn install --offline --frozen-lockfile --ignore-engines --ignore-scripts --no-progress
    patchShebangs node_modules
  '';

  buildPhase = ''
    # Some apps need a build step, but for Electron it's often just the modules.
    # If the app needs a build, you would run 'yarn build' here.
  '';

  installPhase = ''
    mkdir -p $out/lib/${pname}
    cp -r . $out/lib/${pname}

    # Wrapper to launch with Nix Electron
    makeWrapper ${electron}/bin/electron $out/bin/${pname} \
      --add-flags "$out/lib/${pname}" \
      --set ELECTRON_FORCE_IS_PACKAGED 1 \
      --set NODE_ENV production

    # Desktop entry
    mkdir -p $out/share/applications
    cat > $out/share/applications/${pname}.desktop <<EOF
[Desktop Entry]
Name=RingCentral Community
Exec=$out/bin/${pname}
Icon=ringcentral
Type=Application
Categories=Network;Chat;
EOF
  '';
}
