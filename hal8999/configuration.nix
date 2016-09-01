{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the gummiboot efi boot loader.
  boot.loader.systemd-boot.enable = true;
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

  environment.systemPackages = with pkgs; [
    wget
    emacs
    xmonad-with-packages
  ];

  services.openssh.enable = true;
  services.printing.enable = true;
  services.locate.enable = true;
  services.bitlbee.enable = true;
  services.bitlbee.plugins = [ pkgs.bitlbee-facebook ];
  virtualisation.docker.enable = true;

  services.udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0666"
  '';

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  services.xserver.xkbOptions = "ctrl:nocaps";

  # Enable Slim
  services.xserver.desktopManager.xterm.enable = false;

  # Enable Xmonad
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  programs.ssh.startAgent = false;
  services.xserver.windowManager.default = "xmonad";

  hardware.pulseaudio.enable = true;

  # Steam support
  hardware.bumblebee.enable = true;
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  services.xserver.videoDrivers = [ "nvidia" "intel" ];

  nixpkgs.config.allowUnfree = true;  

  programs.zsh.enable = true;
  
  users.extraUsers.mvc = {
    isNormalUser = true;
    uid = 1000;
    home = "/home/mvc";
    extraGroups = [ "wheel" ];
    shell = "/run/current-system/sw/bin/zsh";
    createHome = true;
  };

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

}
