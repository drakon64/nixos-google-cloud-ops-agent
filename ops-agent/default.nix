{
  lib,
  fetchFromGitHub,
  buildGoModule,
}:
let
  pname = "ops-agent";
  version = "2.55.0";
in
buildGoModule {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "GoogleCloudPlatform";
    repo = pname;
    rev = version;
    hash = "sha256-9ktAkqqPbH7Gd21qg8SUtuPAqoUBg6W1YFCoQ/sM68M=";
    fetchSubmodules = true;
  };

  vendorHash = "sha256-+va+DvV2ZJ9cPz/fww1KnPFuoAct6RbRMA4mlQA8xxw=";

  checkFlags =
    let
      # Skip tests that require network access
      skippedTests = [ "TestThirdPartyPublicUrls" ];
    in
    [ "-skip=^${builtins.concatStringsSep "$|^" skippedTests}$" ];

  meta = {
    description = "Ops Agents that are part of the Google Cloud Operations product suite";
    homepage = "https://cloud.google.com/stackdriver/docs/solutions/agents/ops-agent";
    license = lib.licenses.asl20;
    platforms = lib.platforms.linux;
  };
}
