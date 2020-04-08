{ requireFile }:

(
  requireFile rec {
    name = "1891042977.tar.gz";
    sha256 = "01b1r4z8m67l5cvwc57pi62skhxya3h2vd9b1q2cyy6zjknfmif7";
    message = "${name} is missing from NIX_STORE.";
  }
).overrideAttrs (_: { allowSubstitutes = true; })
