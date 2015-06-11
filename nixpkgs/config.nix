pkgs: rec {
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
        pv
        rtorrent
        rxvt_unicode
        taskwarrior
        tmux
        unzip
        weechat
        wget
        xclip
        zip
      ];
    };
  };
}
