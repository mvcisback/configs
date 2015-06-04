pkgs: {
  allowUnfree = true;

  firefox = {
    enableGoogleTalkPlugin = true;
    enableAdobeFlash = true;
  };
    
  packageOverrides = self : rec {

    env = self.haskellngPackages.ghcWithPackages (p: with p; [
      Agda
      yi
    ]);
    
    userPkgs = self.buildEnv {
      name = "userPkgs";
      paths = with self; [
        aspell
        aspellDicts.en
        dmenu
        dunst
        emacs
        env
        ffmpeg
        firefox-bin
        fish
        git
        gnupg
        i3lock
        ii
        imagemagick
        inconsolata
        mpv
        mupdf
        p7zip
        pass
        pavucontrol
        pianobar
        pv
        rawdog
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
