{ pkgs ? import <nixpkgs> {} }:
let 
  programPython = pkgs.python3;
  terraform = pkgs.terraform;
  pythonWithPackages = programPython.withPackages (ps: with ps; [
    matplotlib
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = [ pythonWithPackages terraform ];
  shellHook = ''
    PYTHONPATH=${pythonWithPackages}/${pythonWithPackages.sitePackages}
  '';
}