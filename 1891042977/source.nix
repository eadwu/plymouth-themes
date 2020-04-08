{ requireFile }:

(
  requireFile rec {
    name = "1891042977.tar.gz";
    sha256 = "060jcfk0xrcc2x6hyr5i9s3263glm5cxj1zfdnd12wb7ndaslmqf";
    message = "${name} is missing from NIX_STORE.";
  }
).overrideAttrs (_: { allowSubstitutes = true; })
