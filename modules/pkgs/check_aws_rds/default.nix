{ stdenv, pkgs, fetchurl, python27Packages }:
let

  rev = "4b01b396cf3af8fb68877dc3b5d91f5951b0a58b";

  pmp-check-aws-rds = stdenv.mkDerivation rec {
    name = "pmp-check-aws-rds";
    src = fetchurl {
      url = "https://raw.githubusercontent.com/percona/percona-monitoring-plugins/${rev}/nagios/bin/pmp-check-aws-rds.py";
      sha256 = "03njl0d359ljfw1iicdf6y1x0q0w7ygn4nqixwblqcah6ii3icv8";
    };

    buildInputs = with python27Packages; [ python wrapPython ];
    pythonPath = with python27Packages; [ boto ];
    phases = [ "installPhase" "fixupPhase" ];

    installPhase = ''
      mkdir -p $out/bin
      cp $src $out/bin/${name}
      chmod +x $out/bin/${name}
      wrapPythonPrograms
    '';

  };

in stdenv.mkDerivation {
  name = "check_aws_rds";
  outputs = [ "out" "conf" ];

  phases = [ "installPhase" "fixupPhase" ];
  nativeBuildInputs = with pkgs; [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin

    cp ${./check_aws_rds} $out/bin/check_aws_rds
    cp ${./check_aws_rds.conf} $conf

    chmod +x "$out/bin/"*

    substituteInPlace "$conf" \
      --replace check_aws_rds "$out/bin/check_aws_rds"

    wrapProgram "$out/bin/check_aws_rds" \
      --prefix PATH : "${pmp-check-aws-rds}/bin:${pkgs.bind.dnsutils}/bin"
  '';
}
