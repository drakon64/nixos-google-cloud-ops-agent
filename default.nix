{
  pkgs ? import (import ./npins).nixos-unstable { },
}:
{
  google-cloud-ops-agent = pkgs.callPackage ./google-cloud-ops-agent { };
}
