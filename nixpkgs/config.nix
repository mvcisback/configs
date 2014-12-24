pkgs: {
  packageOverrides = self : rec {
    userPkgs = self.buildEnv {
      name = "userPkgs";
      paths = with self; [
        firefox
        emacs
        dunst
        mpv
        weechat
        dmenu
        taskwarrior
        aspell
        fish
        pinentry
        rxvt_unicode
        pass
        gnupg
        xclip
        slock
        pulseaudio
        pavucontrol
        feh
        (import ./rawdog.nix)
      ];
    };
  };



}
