# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.gummiboot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "hal8999"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    wget
    emacs
    fish
    xmonad-with-packages
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.locate.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable Slim
  services.xserver.displayManager.slim.enable = true;
  services.xserver.desktopManager.xterm.enable = false;

  # Enable Xmonad
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.startGnuPGAgent = true;

  programs.ssh.startAgent = false;
  services.xserver.windowManager.default = "xmonad";

  hardware.pulseaudio.enable = true;

  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.allowUnfree = true;  
  services.unifi.enable = true;

  # Define a user account. Don't forget to set a password with 
  users.extraUsers.mvc = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mvc";
    extraGroups = [ "wheel" "vboxusers" ];
    shell = "/run/current-system/sw/bin/fish";
    createHome = true;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
