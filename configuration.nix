{ config, pkgs, ... }:

{
  imports =
    [ /etc/nixos/hardware-configuration.nix ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.checkJournalingFS = false;

  networking.hostName = "nixos"; # Define your hostname.

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us-acentos";
    defaultLocale = "en_GB.UTF-8";
  };

  services.vmwareGuest.enable = true;

  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
    emacs
    git
    gnupg
    vim
    wget
  ];

  fonts.enableFontDir = true;
  fonts.enableCoreFonts = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [
    bakoma_ttf
    corefonts
    dejavu_fonts
    gentium
    inconsolata
    liberation_ttf
    source-code-pro
    terminus_font
    ubuntu_font_family
  ];

  programs.zsh.enable = true;

  services.openssh.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";
    displayManager.lightdm.enable = true;
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    desktopManager.default = "xfce";
  };

  users.extraUsers.jcf = {
    createHome = true;
    description = "James Conroy-Finn";
    isNormalUser = true;
    home = "/home/jcf";
    extraGroups = [ "networkmanager" "wheel" ];
    uid = 1000;
    shell = "/run/current-system/sw/bin/zsh";
  };

  system.stateVersion = "15.09";
}
