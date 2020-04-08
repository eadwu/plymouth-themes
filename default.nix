{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let
  themes = builtins.attrNames (lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.));

  mkTheme = { pname, version, src, images ? null }: stdenv.mkDerivation {
    inherit pname version src;

    patchPhase = ''
      substituteInPlace ${pname}.plymouth \
        --subst-var-by theme_dir $out/share/plymouth/themes
    '';

    nativeBuildInputs = [ gnutar ];

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/plymouth/themes/${pname}
      cp -r --target-directory=$out/share/plymouth/themes/${pname} *
    '' + lib.optionalString (images != null) ''
      tar xzf ${images} -C $out/share/plymouth/themes/${pname}
    '';
  };
in {
  "1891042977" = mkTheme {
    pname = "1891042977";
    version = "2020-04-07";
    src = lib.cleanSource ./1891042977;
    images = import ./1891042977/source.nix { inherit requireFile; };
  };

  "1987238292" = mkTheme {
    pname = "1987238292";
    version = "2020-04-07";
    src = lib.cleanSource ./1987238292;
    images = import ./1987238292/source.nix { inherit requireFile; };
  };

  geshin-impact-start = mkTheme {
    pname = "geshin-impact-start";
    version = "1.0.38";
    src = lib.cleanSource ./geshin-impact-start;
  };
}
