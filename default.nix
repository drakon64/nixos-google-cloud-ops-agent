{
  pkgs ? import (import ./npins).nixos { },
}:
{
  google-cloud-ops-agent = pkgs.callPackage ./google-cloud-ops-agent { };
}
