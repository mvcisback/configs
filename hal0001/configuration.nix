# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hal0001"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  environment.systemPackages = with pkgs; [
    wget
    emacs
    fish
    xmonad-with-packages
  ];

  services.openssh.enable = true;
  services.printing.enable = true;
  services.locate.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable Slim
  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.theme = pkgs.fetchurl {
    url = "http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/s/sl/slim.berlios/slim-subway.tar.gz";
    sha256 = "0205568e3e157973b113a83b26d8829ce9962a85ef7eb8a33d3ae2f3f9292253";
  };
  services.xserver.desktopManager.xterm.enable = false;

  # Enable Xmonad
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.startGnuPGAgent = true;

  programs.ssh.startAgent = false;
  services.xserver.windowManager.default = "xmonad";

  hardware.pulseaudio.enable = true;

  users.extraUsers.mvc = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mvc";
    extraGroups = [ "wheel" ];
    #shell = "/run/current-system/sw/bin/fish";
    createHome = true;
  };


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
