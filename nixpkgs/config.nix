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
        pulseaudio
        pinentry
        rxvt_unicode
        pass
        gnupg
        xclip
        slock
        (import ./rawdog.nix)
      ];
    };
  };



}
