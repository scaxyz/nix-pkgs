{ lib, fetchFromGitHub, pkgs, rustPlatform, fetchCrate, cargo-cross, pkg-config
, openssl, python3 }:

rustPlatform.buildRustPackage rec {
  pname = "bws";
  version = "v0.3.0";

  src = fetchFromGitHub {
    owner = "bitwarden";
    repo = "sdk";
    rev = "bws-${version}";
    hash = "sha256-o+tmO9E881futhA/fN6+EX2yEBKnKUmKk/KilIt5vYY=";
  };


  cargoSha256 = "sha256-Jj/+P2MDDC5M/BIpa21CN1mQN2c3Xjvp1h87/kON3UI=";
  cargoDepsName = pname;

  buildInputs = [ openssl ];

  nativeBuildInputs = [ pkg-config ];

  buildPhase = "
  runHook preBuild

  cargo build -p bws --release
  
  runHook postBuild";

  installPhase = "
  runHook preInstall
  
  mkdir -p $out/bin
  cp target/release/bws $out/bin/

  runHook postInstall
  ";
  
  doCheck = false;

  meta = with lib; {
    description = "CLI for interacting with the secrets manager.";
    homepage = "https://github.com/bitwarden/sdk";
    license =
      "BITWARDEN SOFTWARE DEVELOPMENT KIT LICENSE AGREEMENT Version 1, 17 March 2023";
    # maintainers = [ scaxyz ];
  };
}
