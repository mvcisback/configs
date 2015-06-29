{ pkgs }:

with pkgs;
let

in rec {
  allowUnfree = true;
  allowBroken = true;

  firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };

  packageOverrides = self : rec {

    graphical = self.buildEnv {
      name = "graphicalPkgs";
      paths = with self; [
        firefoxWrapper
        i3lock
        mpv
        rofi
        steam
        xcompmgr
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
        pwgen
        pv
        rtorrent
        rxvt_unicode
        taskwarrior
        tmux
        tmuxinator
        unzip
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

  };
}
