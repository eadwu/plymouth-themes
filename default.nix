{ nixpkgs ? import <nixpkgs> {} }:

with nixpkgs;

let
  themes = builtins.attrNames (lib.filterAttrs (_: v: v == "directory") (builtins.readDir ./.));

  mkTheme = { pname, version, src, images }: stdenv.mkDerivation {
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
in lib.genAttrs themes
  (theme: let
    themedir = ./. + "/${theme}";
    _args = import "${themedir}/spec.nix";
    images = if (builtins.pathExists "${themedir}/source.nix")
      then import "${themedir}/source.nix" { inherit requireFile; }
      else null;

    args = _args // { inherit images; src = lib.cleanSource themedir; };
  in mkTheme args)
