{
  lib,
  fetchFromGitHub,
  fetchzip,
  buildGoModule,
}:
let
  pname = "ops-agent";
  version = "2.55.0";
in
buildGoModule {
  inherit pname version;

  # TODO: Fix `tar: This does not look like a tar archive`
  #src = fetchFromGitHub {
  #  owner = "GoogleCloudPlatform";
  #  repo = pname;
  #  rev = version;
  #  hash = "";
  #};

  # TODO: Replace this with fetchFromGitHub
  src = fetchzip {
    url = "https://github.com/GoogleCloudPlatform/${pname}/archive/refs/tags/${version}.tar.gz";
    hash = "sha256-qvtk9pWzdSptD60EUPxxZ686hwM22iIN5k+bLM5mzPU=";
  };

  vendorHash = "sha256-+va+DvV2ZJ9cPz/fww1KnPFuoAct6RbRMA4mlQA8xxw=";

  checkFlags =
    let
      # Skip tests that require network access
      skippedTests = [ "TestThirdPartyPublicUrls" ];
    in
    [ "-skip=^${builtins.concatStringsSep "$|^" skippedTests}$" ];

  meta = {
    license = lib.licenses.asl20;
  };
}
