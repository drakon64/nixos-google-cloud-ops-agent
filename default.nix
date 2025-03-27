{
  pkgs ? import (import ./npins).nixpkgs { },
}:
{
  ops-agent = pkgs.callPackage ./ops-agent { };
}
