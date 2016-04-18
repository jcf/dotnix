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
    consoleKeyMap = "uk";
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
    layout = "gb";
    xkbOptions = "eurosign:e";
    displayManager.lightdm.enable = true;
    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    desktopManager.xterm.enable = false;
    desktopManager.xfce.enable = true;
    desktopManager.default = "xfce";
  };

  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    environment = {
      GTK_DATA_PREFIX = config.system.path;
      SSH_AUTH_SOCK = "%t/ssh-agent";
      GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
    };
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.emacs}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs}/bin/emacsclient --eval (kill-emacs)";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };
  systemd.services.emacs.enable = true;

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
