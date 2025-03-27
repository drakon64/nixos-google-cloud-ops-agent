{
  pkgs ? import (import ./npins).nixpkgs { },
}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    nixfmt-rfc-style
    npins
  ];
}
