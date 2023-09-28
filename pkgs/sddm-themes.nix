{ stdenv, fetchFromGitHub }:
{
  sddm-astronaut-theme = stdenv.mkDerivation rec {
    pname = "sddm-astronaut-theme";
    version = "f9f08c5";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/astronaut-theme
    '';
    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      #rev = "v${version}";
      rev = "f9f08c53cb45d481317f029e3e30ffae9e68d465";
      sha256 = "I39W9U4j/MbyYp4BlB4sWuQ5GVf/z4bm4ohrSfIWcXI=";
    };
  };
}
