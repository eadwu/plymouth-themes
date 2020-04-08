{ requireFile }:

(
  requireFile rec {
    name = "1987238292.tar.gz";
    sha256 = "0qxv0az22q43wchb6i0cr6llpisb3baaq68hcfbdnd8mw26gyhal";
    message = "${name} is missing from NIX_STORE.";
  }
).overrideAttrs (_: { allowSubstitutes = true; })
