{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration-nano.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nano"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.pulseaudio.enable = true;
  
  # internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
     wget
     git
     fish
     i3lock
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable Slim
  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.theme = pkgs.fetchurl {
    url = "http://www.mirrorservice.org/sites/download.sourceforge.net/pub/sourceforge/s/sl/slim.berlios/slim-subway.tar.gz";
    sha256 = "0205568e3e157973b113a83b26d8829ce9962a85ef7eb8a33d3ae2f3f9292253";
  };
  
  # Enable Xmonad
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;
  services.xserver.windowManager.default = "xmonad";  
  services.xserver.desktopManager = "none";
  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.mvc = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mvc";
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/fish";
    createHome = true;
  };

}
