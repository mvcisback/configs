# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let

  # https://github.com/pSub/configs/blob/master/nixos/configuration.nix
  # Displays an alert if the battery is below 10%
  lowBatteryNotifier = pkgs.writeScript "lowBatteryNotifier"
    ''
      BAT_PCT=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '[0-9]+(?=%)'`
      BAT_STA=`${pkgs.acpi}/bin/acpi -b | ${pkgs.gnugrep}/bin/grep -P -o '\w+(?=,)'`
      test $BAT_PCT -le 10 && test $BAT_STA = "Discharging" && DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send 'Low Battery'
    '';

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.trackpoint.emulateWheel = true;
  # boot.plymouth.enable = true;
  boot.tmpOnTmpfs = true;
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking
  networking.hostName = "OogieBoogie"; # Define your hostname.
  networking.extraHosts =
  ''
    login.eecs.berkeley.edu eecs
    128.32.171.35 yggdrasil
  '';
  networking.networkmanager.enable = true;
  networking.nameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  i18n.consoleUseXkbConfig = true;
  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  hardware.u2f.enable = true;
  services.udev.packages = [ 
    pkgs.libu2f-host
    pkgs.yubikey-personalization
  ];
  services.pcscd.enable = true;  # smart card for yubikey
  services.dbus.socketActivated = true;
  services.autorandr.enable = true;
  services.unclutter.enable = true;
  services.logind.extraConfig =
    # I hate accidentally hitting the power key and watching my laptop die ...
    ''
      HandlePowerKey=suspend
    '';
  services.fstrim.enable = true;
  services.cron.enable = true;
  services.cron.mailto = "mvc";
  services.cron.systemCronJobs = [
    "30 23 * * * mvc DISPLAY=:0.0 ${pkgs.libnotify}/bin/notify-send 'Time to go to bed'"
    "* * * * *   mvc ${lowBatteryNotifier}"
    "@weekly     root   nix-collect-garbage"
];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (import ./emacs.nix { inherit pkgs; })
    aspell
    aspellDicts.en
    binutils
    dmenu
    dunst
    feh
    ffmpeg-full
    firefox-devedition-bin
    fish
    flameshot # screenshot
    freetype
    gcc
    gimp
    git
    gnumake
    gnupg
    graphviz
    imagemagick
    inconsolata
    inkscape
    keynav
    libnotify
    lsof
    mosh
    mpv
    networkmanagerapplet
    notmuch
    nox
    offlineimap
    openssl
    pass
    pavucontrol
    pianobar
    protonmail-bridge
    pv  # Montior data going across pipe
    pwgen
    python3Full
    rxvt_unicode
    sshfs
    stalonetray
    stdenv
    stow
    texlive.combined.scheme-full
    tree
    unzip
    wget
    xclip
    xmonad-with-packages
    xorg.xbacklight
    xorg.xrandr
    yubioath-desktop
    zathura
    zip
    zlib
    v4l_utils
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.mosh.enable = true;
  programs.mtr.enable = true;
  programs.tmux.enable = true;
  programs.tmux.newSession = true;
  programs.tmux.terminal = "screen-256color";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "no";
  services.openssh.passwordAuthentication = false;

  # Random Services.
  services.gnome3.gnome-keyring.enable = true;

  services.compton.enable = true;
  services.urxvtd.enable = true;
  services.locate.enable = true;
  services.redshift.enable = true;
  #services.redshift.brightness.day = "0.8";
  #services.redshift.brightness.night = "0.4";
  services.redshift.latitude = "37.7749";
  services.redshift.longitude = "-122.4194";
  services.geoclue2.enable = true;
  #services.offlineimap = {
  #    enable = true;
  #    path = [ 
  #      pkgs.pass 
  #      pkgs.notmuch
  #      pkgs.python3Full
  #   ];
  #};
   services.mbpfan.enable = true;

  # Emacs
  services.emacs = {
      defaultEditor = true;
      enable = true;
      install = true;
      package = (import ./emacs.nix { inherit pkgs; });
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ 55556 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
  hardware.bluetooth.enable = true;
  # keyboard backlight
  programs.kbdlight.enable = true;
  programs.light.enable = true;
  # sound.mediaKeys.enable = true;
  services.actkbd.enable = true;
  systemd.services.mbp-fixes = {
    description = "Fixes for MacBook Pro";
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "multi-user.target" "post-resume.target" ];
    script = ''
      if [[ "$(cat /sys/class/dmi/id/product_name)" == "MacBookPro11,3" ]]; then
        if [[ "$(${pkgs.pciutils}/bin/setpci  -H1 -s 00:01.00 BRIDGE_CONTROL)" != "0000" ]]; then
          ${pkgs.pciutils}/bin/setpci -v -H1 -s 00:01.00 BRIDGE_CONTROL=0
        fi
        echo 5 > /sys/class/leds/smc::kbd_backlight/brightness
        if ${pkgs.gnugrep}/bin/grep -q '\bXHC1\b.*\benabled\b' /proc/acpi/wakeup; then
          echo XHC1 > /proc/acpi/wakeup
        fi
              fi
    '';
    serviceConfig.Type = "oneshot";
  };
  # services.illum.enable = true;

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "ctrl:nocaps";

    # macbook stuff
    deviceSection = ''
      Option   "NoLogo"         "TRUE"
      Option   "DPI"            "96 x 96"
      Option   "Backlight"      "gmux_backlight"
      Option   "RegistryDwords" "EnableBrightnessControl=1"
    '';

    # Enable touchpad support.
    libinput.enable = true;
    libinput.naturalScrolling = true;

    #desktopManager.gnome3.enable = true;
    desktopManager.default = "none";
    #displayManager.lightdm.enable = fire;
    #displayManager.slim.enable = true;
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

  services.actkbd.bindings = [
    { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -U 4"; }
    { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -A 4"; }
    { keys = [ 229 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight down"; }
    { keys = [ 230 ]; events = [ "key" "rep" ]; command = "${pkgs.kbdlight}/bin/kbdlight up"; }
    { keys = [ 121 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle"; }
    { keys = [ 122 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}- unmute"; }
    { keys = [ 123 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}+ unmute"; }
  ];  

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.pulseaudio = true;
  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.mutableUsers = false;
  users.extraUsers.mvc = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mvc";
    extraGroups = [ "wheel" "audio" "fuse" ];
    shell = "/run/current-system/sw/bin/fish";
    createHome = true;
  };

  users.extraUsers.mrz = {
    isNormalUser = true;
    uid = 1001;
    home = "/home/mrz";
    extraGroups = [ "audio" ];
    createHome = true;
  };

  nix.autoOptimiseStore = true;
  #nix.buildCores = 0;

  #nix.buildMachines = [ {
  #  hostName = "yggdrasil";
  #  sshUser = "mvc";
  #  sshKey = "/root/.ssh/nix_remote";
  #  system = "x86_64-linux";
  #  maxJobs = 2;
  #  speedFactor = 2;
  #  supportedFeatures = [ ];
  #  mandatoryFeatures = [ ];
	#}] ;
	# nix.distributedBuilds = false;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
