/*
This is a nix expression to build Emacs and some Emacs packages I like
from source on any distribution where Nix is installed. This will install
all the dependencies from the nixpkgs repository and build the binary files
without interfering with the host distribution.

To build the project, type the following from the current directory:

$ nix-build emacs.nix

To run the newly compiled executable:

$ ./result/bin/emacs
*/
{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    ace-jump-mode
    haskell-mode
    cdlatex
    company
    #company-auctex
    impatient-mode
    magit          # ; Integrate git <C-x g>
    markdown-mode
    protobuf-mode
    rust-mode
    solarized-theme
    yasnippet
    yaml-mode
  ]) ++ (with epkgs.melpaPackages; [
    haskell-mode
    #undo-tree      # ; <C-x u> to show the undo tree
    nix-mode
    z3-mode
    # yasnippet-snippets
    # zoom       # ; increase/decrease font size for all buffers %lt;C-x C-+>
    web-mode
  ]) ++ (with epkgs.elpaPackages; [
    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    nameless       # ; hide current package name everywhere in elisp code
  ]) ++ [
    pkgs.notmuch   # From main packages set
  ])
