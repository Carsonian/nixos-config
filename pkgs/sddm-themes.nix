{ stdenv, fetchFromGitHub }:
{
  sddm-astronaut-theme = stdenv.mkDerivation rec {
    pname = "sddm-astronaut-theme";
    #version = "1.2";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/astronaut-theme
    '';
    src = fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      #rev = "v${version}";
      #sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
    };
  };
}
