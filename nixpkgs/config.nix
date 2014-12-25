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
        pulseaudio
        pavucontrol
        feh
        imagemagick
        haskellPackages.yi
        haskellPackages.pandoc
        tmux
        (import ./rawdog.nix)
      ];
    };
  };
}
