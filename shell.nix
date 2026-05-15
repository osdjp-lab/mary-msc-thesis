{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.aspellWithDicts (d: with d; [ en ]))
    pkgs.texlive.combined.scheme-full
    pkgs.gnumake
  ];
}
