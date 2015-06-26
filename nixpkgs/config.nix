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
    userPkgs = self.buildEnv {
      name = "userPkgs";
      paths = with self; [
        aspell
        aspellDicts.en
        autojump
        dmenu
        dunst
        emacs
        ffmpeg
        firefoxWrapper
        fish
        git
        gnupg
        i3lock
        imagemagick
        inconsolata
        mpv
        mupdf
        p7zip
        pass
        pavucontrol
        pianobar
        pwgen
        pv
        remind
        rofi
        rtorrent
        rxvt_unicode
        steam
        taskwarrior
        tmux
        tmuxinator
        todo-txt-cli
        unzip
        weechat
        wget
        xclip
        zip
      ];
    };
  };
}
