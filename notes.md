## Shell to try package

```nix
with import <nixpkgs> { };
let myPackage = pkgs.callPackage ./default.nix { };
in pkgs.mkShell rec { buildInputs = [ myPackage ]; }
```

## Store cleaning script

```bash
#!/bin/bash
$packageName = $1

find /nix/store \
    \( -name '*$packageName-*' \) \
    -exec nix store delete -v {} +

```