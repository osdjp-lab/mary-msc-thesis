{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [
    # Spell‑checking with English dictionary
    (pkgs.aspellWithDicts (d: with d; [ en ]))

    # Full TeX Live distribution
    pkgs.texlive.combined.scheme-full

    # GNU Make
    pkgs.gnumake

    # Python 3 with scientific packages
    (pkgs.python3.withPackages (ps: with ps; [
      numpy
      pandas
      matplotlib
      seaborn
      scipy
      statsmodels
    ]))

    # csvkit utilities
    pkgs.csvkit
  ];
}
