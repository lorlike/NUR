{ stdenv, fetchurl, lib }:
let
  version = "0.2.15";
  archMap = {
    "x86_64-linux" = {
      name = "x86_64";
      hash = "sha256-HLqocTyyOmVeVEIw0R0o4hZBMYiWY/BS5GdGhvhme0I="; 
    };
    "aarch64-linux" = {
      name = "aarch64";
      hash = "sha256-nzkDN9oNSIsJdEtWREYbWI9D+sebE7LKaWKMYgcAxzg="; 
    };
  };
  currentArch = archMap.${stdenv.hostPlatform.system}
    or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  baseUrl = "https://github.com/akirco/pigma/releases/download/v${version}";
in
stdenv.mkDerivation {
  pname = "pigma";
  inherit version;
  src = fetchurl {
    url = "${baseUrl}/pigma-${currentArch.name}-unknown-linux-gnu.tar.gz";
    hash = currentArch.hash;
  };
  dontBuild = true;
  sourceRoot = ".";
  installPhase = "install -Dm755 pigma $out/bin/pigma";

  meta = with lib; {
    description = "A NetEase Cloud Music (网易云音乐) or local audio playback TUI client built with Ratatui.";
    homepage = "https://github.com/akirco/pigma";
    license = licenses.asl20;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "pigma";
  };
}
