{ lib, fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "yaegi";
  version = "0.15.1";

  src = fetchFromGitHub {
    owner = "traefik";
    repo = "yaegi";
    rev = "v${version}";
    sha256 = "sha256-ZV1HidHJvwum18QIIwQiCcRcitZdHk5+FxkPs6YgDac=";
  };

  vendorHash = null;
  subPackages = [ "cmd/yaegi" ];
  ldflags = [ "-s" "-w" "-X=main.version=v${version}" ];

  doCheck = true;

  meta = with lib; {
    description = "Yaegi is Another Elegant Go Interpreter";
    homepage = "https://github.com/traefik/yaegi";
    license = licenses.asl20;
    # maintainers = with maintainers; [ scaxyz ];
  };
}
