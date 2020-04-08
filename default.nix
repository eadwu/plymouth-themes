{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;
with lib;

let
  themes = builtins.attrNames (filterAttrs (_: v: v == "directory") (builtins.readDir ./.));

  mkTheme = { pname, version, src, images ? null, ... }@args: stdenv.mkDerivation (args // {
    inherit pname version src;

    patchPhase = optionalString (args ? prePatch) args.prePatch + ''
      substituteInPlace ${pname}.plymouth \
        --subst-var-by theme_dir $out/share/plymouth/themes
    '' + optionalString (args ? postPatch) args.postPatch;

    nativeBuildInputs = [ gnutar ]
      ++ (optionals (args ? nativeBuildInputs) args.nativeBuildInputs);

    dontBuild = true;

    installPhase = optionalString (args ? preInstall) args.preInstall + ''
      mkdir -p $out/share/plymouth/themes/${pname}
      cp -r --target-directory=$out/share/plymouth/themes/${pname} *
    '' + optionalString (images != null) ''
      tar xzf ${images} -C $out/share/plymouth/themes/${pname}
    '' + optionalString (args ? postInstall) args.postInstall;
  });
in {
  "1891042977" = mkTheme {
    pname = "1891042977";
    version = "2020-04-07";
    src = cleanSource ./1891042977;
    images = import ./1891042977/source.nix { inherit requireFile; };
  };

  "1987238292" = mkTheme {
    pname = "1987238292";
    version = "2020-04-07";
    src = cleanSource ./1987238292;
    images = import ./1987238292/source.nix { inherit requireFile; };
  };

  geshin-impact-start = mkTheme {
    pname = "geshin-impact-start";
    version = "1.0.38";
    src = cleanSource ./geshin-impact-start;
  };
}
