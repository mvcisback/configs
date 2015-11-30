{ pkgs }:

with pkgs;
let

in rec {
  allowUnfree = true;
  allowBroken = true;

  packageOverrides = self : rec {

  email = self.buildEnv {
    name = "emailPkgs";
    paths = with self; [
      notmuch
      isync
      lynx
      msmtp
    ];
  };

  general = self.buildEnv {
    name = "generalPkgs";
    paths = with self; [
      #aspell
      #aspellDicts.en
      autojump
      dmenu
      dunst
      #emacs
      feh
      ffmpeg-full
      fish
      git
      gnupg
      imagemagick
      inconsolata
      mosh
      mupdf
      nix
      nmap
      p7zip
      pass
      pciutils
      pianobar
      pwgen
      pv
      rtorrent
      taskwarrior
      unzip
      usbutils
      v4l_utils
      weechat
      wget
      xclip
      zip
    ];
  };
  
  desktopPkgs = self.buildEnv {
    name = "desktopPkgs";
    paths = with self; [
      general
      devPkgs
    ];
  };

  devPkgs = self.buildEnv {
    name = "devPkgs";
    paths = with self; [
      capnproto
      clang
      gcc-arm-embedded
      gcc
      glibc
      graphviz
      minicom
      xorg.libX11
      xorg.libXtst
      pandoc
      protobuf
      protobufc
      spin
      ttylog
    ];
  };
};
}
