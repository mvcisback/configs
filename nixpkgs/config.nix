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
      aspell
      aspellDicts.en
      autojump
      dmenu
      dunst
      emacs
      feh
      ffmpeg-full
      fish
      git
      gnupg
      imagemagick
      inconsolata
      mosh
      mpv
      mupdf
      nmap
      p7zip
      pass
      pciutils
      pianobar
      pwgen
      pv
      rtorrent
      rxvt_unicode
      taskwarrior
      tmux
      unzip
      usbutils
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
      graphviz
      minicom
      pandoc
      protobuf
      protobufc
      spin
      ttylog
    ];
  };
};
}
