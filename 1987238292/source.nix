{ requireFile }:

(
  requireFile rec {
    name = "1987238292.tar.gz";
    sha256 = "0adfrvnw4d931v282w1965b3rjfhsj7yz4b9ph715h30h372mlr1";
    message = "${name} is missing from NIX_STORE.";
  }
).overrideAttrs (_: { allowSubstitutes = true; })
