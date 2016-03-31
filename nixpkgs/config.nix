{ pkgs }:

with pkgs;
let

in rec {
  allowUnfree = true;
  allowBroken = true;

  packageOverrides = self : rec {

  pandocEnv = pkgs.haskellPackages.ghcWithPackages (p: with p; [
    pandoc
    pandoc-citeproc
  ]);

  
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
      tmux
      tree
      unzip
      usbutils
      v4l_utils
      weechat
      wget
      xcalib
      xclip
      zip
    ];
  };
  
  desktopPkgs = self.buildEnv {
    name = "desktopPkgs";
    paths = with self; [
      general
      devPkgs
      rxvt_unicode
      firefox
      mpv
      chromium {
        enablePepperFlash = true;
      }
      xorg.xrandr
      pavucontrol
      zathura
      i3lock
      autorandr
    ];
  };

  devPkgs = self.buildEnv {
    name = "devPkgs";
    paths = with self; [
      stdenv
      graphviz
      gnumake
      minicom
      pandocEnv
      ttylog
      texLiveFull
    ];
  };
};
}
