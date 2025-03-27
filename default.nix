{
  pkgs ? import (import ./npins).nixos-unstable { },
}:
{
  ops-agent = pkgs.callPackage ./ops-agent { };
}
