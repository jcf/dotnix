{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  boot.initrd.checkJournalingFS = false;

  networking.hostName = "lime";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  time.timeZone = "Europe/London";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    emacs
    git
    mosh
    vim
    wget
  ];

  services.openssh.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  users.extraUsers.jcf = {
    createHome = true;
    description = "James Conroy-Finn";
    extraGroups = [ "wheel" "cdrom" "disk" "networkmanager" ];
    home = "/home/jcf";
    isNormalUser = true;
    shell = "/run/current-system/sw/bin/zsh";
    uid = 1000;

    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCla5pT6waAIhSbp6qMq7OmpsxEqm7JcRU2NWOXQFYVE+vi3hcys8Rovg30mGDoul1JpGGTzMMtClFeYuEfS6MdNyRK70EqO1uHkFyZUBLxsrx48tiNVbDsCQvZMZ/fBnMfDI4tO1VOcwZ+ElK8+3qEke3F3WS9YRCAKa6k2sCjdzE9Fvo2Ji1uOPl5RLsm6yxmSWDLKO4f3NDC9e/NNH/keWzw05sMRDXKi8jFXzLZQO6dZZ3McFhMkRRJE2mSs52s0HE7Az1NQSk3kzmApj5LOv1Y6PJXR2LhtfZpuof2LuEbMzQpYpJ45y3bTAAssT2t/SDwqmHnKGzYG4oNB2DF" ];
  };

  security.sudo.enable = true;

  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "15.09";

  fileSystems = [
    { mountPoint = "/";
      label = "nixos";
    }
  ];
}
