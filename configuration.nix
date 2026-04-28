{ config, pkgs, ... }:

{
	imports =
		[ # Include the results of the hardware scan.
			./hardware-configuration.nix
		];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];

	# Enable Home Manager
	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	home-manager.users.jazz = import ./home.nix;

	# Enable the Hyprland window manager
	programs.hyprland.enable = true;

	# Enable the Ly display manager
	services.displayManager.ly.enable = true;

	# Bootloader.
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "nodev";
	boot.loader.grub.efiSupport = true;
	# boot.loader.grub.useOSProber = false;
	boot.loader.efi.canTouchEfiVariables = true;

	# Enable networking
	networking.hostName = "nixos"; # Define your hostname.
	networking.networkmanager.enable = true;

	# Enable Bluetooth
	hardware.bluetooth.enable = true;

	# Enable Docker
	virtualisation.docker.enable = true;

	users.defaultUserShell = pkgs.zsh;
	programs.zsh.enable = true;

	# Set your time zone.
	time.timeZone = "Europe/Stockholm";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_GB.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_GB.UTF-8";
		LC_IDENTIFICATION = "en_GB.UTF-8";
		LC_MEASUREMENT = "en_GB.UTF-8";
		LC_MONETARY = "en_GB.UTF-8";
		LC_NAME = "en_GB.UTF-8";
		LC_NUMERIC = "en_GB.UTF-8";
		LC_PAPER = "en_GB.UTF-8";
		LC_TELEPHONE = "en_GB.UTF-8";
		LC_TIME = "en_GB.UTF-8";
	};

	# Configure keymap in X11
	services.xserver.xkb = {
		layout = "gb";
		variant = "";
	};

	# Configure console keymap
	console.keyMap = "uk";

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.jazz = {
		isNormalUser = true;
		description = "jazz";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;


	# System packages
	environment.systemPackages = with pkgs; [
		efibootmgr
		wget
		gcc
		gnumake
		ripgrep
	];

	system.stateVersion = "25.11";

	fonts.packages = with pkgs; [
		font-awesome_4
		noto-fonts
		noto-fonts-cjk-sans
		noto-fonts-color-emoji
		liberation_ttf
		fira-code
		fira-code-symbols
		mplus-outline-fonts.githubRelease
		dina-font
		proggyfonts
		nerd-fonts.jetbrains-mono
	];


}
