{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs;[
    kustomize
    yq-go
    act
  ];
}
