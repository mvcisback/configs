{ pkgs }:

with pkgs;
let
  stdenv = pkgs.stdenv;
in rec {
  allowUnfree = true;
  allowBroken = true;
}
