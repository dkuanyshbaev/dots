# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # config
  #nix.nixPath = lib.mkDefault [
  #  "nixos-config=/home/denis/configs/conf.nix"
  #];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nostromo";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Bangkok";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure X11
  services.xserver = {
    enable = true;
    # dpi
    dpi = 192;
    # wm
    #displayManager.lightdm.enable = false;
    windowManager.dwm.enable = true;
    # keyboard
    autoRepeatDelay = 350;
    autoRepeatInterval = 25;
    # keymap
    layout = "us,ru";
    xkbVariant = "";
    # touchpad
    libinput.enable = true;
    libinput.touchpad.naturalScrolling = true;
  };

  services.udisks2.enable = true;

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE:="666"
  '';

 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    st
    vim
    git
    acpi
    wget
    curl
    htop
    dmenu
    ctags
    rustup
    clang
    cmake 
    libclang 
    protobufc
    sqlite
    gnupg
    #tiramisu
    brightnessctl
    feh
    nnn
    cmus
    zathura
    nethack
    helix
    bat
    vis
    milkytracker
    #nix-prefetch-github
  ];

  # Kill nano and friends
  environment.defaultPackages = [];

  # Set envs
  environment.variables = {
    EDITOR = "vim";
  };

  #sound.enable = true;
  hardware.pulseaudio.enable = true;
  #hardware.pulseaudio.package = pkgs.pulseaudioFull;
  boot.extraModprobeConfig = ''
  options snd-intel-dspcfg dsp_driver=1
  '';

  # Define a user account.
  users.users.denis = {
    isNormalUser = true;
    description = "denis";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [ firefox surf ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Overlays
  # nix-prefetch-github dkuanyshbaev configs
  # nix-prefetch-url patch_url
  nixpkgs.overlays = [
    (self: super: 
      #let 
      #  git_config = super.fetchFromGitHub {
      #    owner = "dkuanyshbaev";
      #    repo = "configs";
      #    rev = "8d364f8ce7322ca259285d922adf9d7e59220f97"; 
      #    sha256 = "4//ebbaXup32PXQ0Q4ccApPq4IE6YeDEIUdeXFi3lnY="; 
      #  };
      #in 
      {

      dwm = super.dwm.override {
        #conf = builtins.readFile "${git_config}/dwm-config.h";
        conf = builtins.readFile "/home/denis/src/configs/dwm-config.h";
        patches = [
          #(super.fetchpatch {
          #  url = "https://raw.githubusercontent.com/dkuanyshbaev/patches/main/dwm-patch.diff";
          #  sha256 = "113wsvmyvrv0a2ikmr9hzmpiwcm3vnm0i5azg449r02q6ag83z4f";
	  #})
        ];
      };

      st = super.st.override {
        #st = super.st.overrideAttrs (oldAttrs: rec {
        #configFile = super.writeText "config.def.h" (builtins.readFile "${git_config}/st-config.h");
        #prePatch = oldAttrs.prePatch or "" + "cp ${configFile} config.def.h";
        patches = [
          (super.fetchpatch {
            url = "https://st.suckless.org/patches/nordtheme/st-nordtheme-0.8.5.diff";
            sha256 = "1zs5z25s9s5zbfr3g46c9h6ffbmdg1dj6cf5ygf5zgpqf3a6jnjf";
          })
          (super.fetchpatch {
            url = "https://st.suckless.org/patches/anysize/st-anysize-20220718-baa9357.diff";
            sha256 = "1ym5d2f85l3avgwf9q93aymdg23aidprqwyh9s1fdpjvyh80rvvq";
          })
          (super.fetchpatch {
            url = "https://st.suckless.org/patches/hidecursor/st-hidecursor-0.8.3.diff";
            sha256 = "1p8laqp3pdvq00p46r9jphy4wq0kz0iwj34r9n2whzi95a7jvfri";
	  })
          (super.fetchpatch {
            url = "https://st.suckless.org/patches/scrollback/st-scrollback-20210507-4536f46.diff";
            sha256 = "072icbmj7my4c134d5apqw7v9q88vcrp6v6gdzf3668dzpkz9n0r";
	  })
          (super.fetchpatch {
            #url = "https://raw.githubusercontent.com/dkuanyshbaev/patches/main/st-patch.diff";
            url = "https://raw.githubusercontent.com/dkuanyshbaev/configs/main/st-font-patch.diff";
            sha256 = "113wsvmyvrv0a2ikmr9hzmpiwcm3vnm0i5azg449r02q6ag83z4f";
	  })
        ];
      };
    })
  ];

  programs.slock.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  #programs.gnupg.agent = {
  #  enable = true;
  #  enableSSHSupport = true;
  #};

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
