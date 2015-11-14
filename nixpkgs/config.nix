{ pkgs }:

with pkgs;
let

in rec {
  allowUnfree = true;
  allowBroken = true;

  packageOverrides = self : rec {

  graphical = self.buildEnv {
    name = "graphicalPkgs";
    paths = with self; [
      firefox
      i3lock
      mpv
      rofi
      steam
      xcompmgr
    ];
  };

  email = self.buildEnv {
    name = "emailPkgs";
    paths = with self; [
      python27Packages.alot
      notmuch
      isync
      lynx
      msmtp
    ];
  };

  audio = self.buildEnv {
      name = "audioPkgs";
      paths = with self; [
        pavucontrol
        pianobar
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
      email
      ffmpeg
      fish
      git
      gnupg
      imagemagick
      inconsolata
      mosh
      mupdf
      p7zip
      pass
      pciutils
      pwgen
      pv
      rtorrent
      rxvt_unicode
      taskwarrior
      tmux
      tmuxinator
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
      audio
      general
      graphical
    ];
  };
  
  remotePkgs = self.buildEnv {
    name = "remotePkgs";
    paths = with self; [
      general
      nix
    ];
  };

  devPkgs = self.buildEnv {
    name = "devPkgs";
    paths = with self; [
      (pkgs.texLiveAggregationFun { paths = [
       pkgs.texLive
       pkgs.texLiveExtra
       pkgs.lmodern
      ]; })
    ];
  };

  };
}
