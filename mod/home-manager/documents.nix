{ pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-small latexmk;
  });
in
{
  home.packages = with pkgs; [
    typst
    tex
    # typst-live
  ];
}
