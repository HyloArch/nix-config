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
    coq
    coqPackages.coq-lsp
    # typst-live
  ];
}
