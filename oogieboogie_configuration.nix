# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # virtualization
  virtualisation.virtualbox.host.enable = true;

  # networking
  networking.hostName = "OogieBoogie"; # Define your hostname.
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  hardware.u2f.enable = true;
  services.udev.packages = [ pkgs.libu2f-host ];
  services.dbus.socketActivated = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    abc-verifier
    aiger
    aspell
    aspellDicts.en
    binutils
    cryptominisat
    dmenu
    dunst
    feh
    ffmpeg-full
    firefox
    fish
    freetype
    gcc
    gimp
    git
    glucose
    gnumake
    gnupg
    graphviz
    imagemagick
    inconsolata
    inkscape
    keynav
    libpng
    lsof
    mate.mate-applets
    minisat
    mosh
    mpv
    networkmanagerapplet
    nox
    openssl
    pass
    pavucontrol
    pianobar
    pkgconfig
    pv
    pwgen
    python36Packages.bugwarrior
    python3Full
    rxvt_unicode
    stdenv
    stow
    taskwarrior
    texlive.combined.scheme-full
    tree
    unzip
    virtualbox
    wget
    xclip
    xmonad-with-packages
    xorg.xrandr
    zathura
    zip
    zlib
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.tmux.enable = true;
  programs.tmux.newSession = true;
  programs.tmux.terminal = "screen-256color";
  programs.mosh.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  # Random Services.
  services.urxvtd.enable = true;
  services.locate.enable = true;
  services.redshift.enable = true;
  #services.redshift.brightness.day = "0.8";
  #services.redshift.brightness.night = "0.4";
  services.redshift.latitude = "37.7749";
  services.redshift.longitude = "-122.4194";
  services.geoclue2.enable = true;
  services.syncthing = {
      enable = true;
      user = "mvc";
      systemService = false;
      dataDir = "/home/mvc/syncthing";
  };

  # Emacs
  services.emacs = {
      defaultEditor = true;
      enable = true;
      install = true;
      package = (import ./emacs.nix { inherit pkgs; });
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ 55556 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";

    # Enable touchpad support.
    libinput.enable = true;
    desktopManager.mate.enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = haskellPackages: [
        haskellPackages.xmonad-contrib
        haskellPackages.xmonad-extras
        haskellPackages.xmonad
      ];
    };
    windowManager.default = "xmonad";
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mvc = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mvc";
    extraGroups = [ "wheel" "audio" "networkmanager"];
    shell = "/run/current-system/sw/bin/fish";
    createHome = true;
  };

  users.extraUsers.mrz = {
    isNormalUser = true;
    uid = 1001;
    home = "/home/mrz";
    extraGroups = [ "audio" "networkmanager"];
    createHome = true;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
