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

	# Configure the lid for laptops
	services.logind.settings.Login = {
	  HandleLidSwitch = "ignore";
	};

	# Bootloader
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "nodev";
	boot.loader.grub.efiSupport = true;
	# boot.loader.grub.useOSProber = false;
	boot.loader.efi.canTouchEfiVariables = true;

	# Enable networking
	networking.hostName = "nixos"; # Define your hostname.
	networking.networkmanager.enable = true;
	networking.hosts = {
		"192.168.0.151" = ["kevin"];
	};

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
		layout = "gb,se";
		variant = "";
        options = "";
	};

	# Configure console keymap
	console.keyMap = "uk";

	# Define user accounts
	users.users.jazz = {
		isNormalUser = true;
		description = "jazz";
		extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
	};

	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;


	# System packages
	environment.systemPackages = with pkgs; [
		efibootmgr
		wget
		gcc
		gnumake
		cargo
		ripgrep
		wl-clipboard
		libreoffice-qt
		hunspell # libreoffice dependency
		hunspellDicts.en_GB-ise # hunspell dependency
		hunspellDicts.sv_SE # hunspell dependency
		wgnord
		wireguard-tools
	];

	# wgnord needs /etc/wireguard to write its generated WireGuard config
	systemd.tmpfiles.rules = [
		"d /etc/wireguard 0700 root root -"
	];

	# wgnord stores credentials and template.conf in /var/lib/wgnord.
	# The nixpkgs package doesn't create this directory or provide template.conf,
	# so we do it here on activation. Only creates template.conf if missing
	# (preserves any user customisations).
	system.activationScripts.wgnord = ''
		mkdir -p /var/lib/wgnord
		if [ ! -f /var/lib/wgnord/template.conf ]; then
			cat > /var/lib/wgnord/template.conf <<'EOF'
[Interface]
PrivateKey = PRIVKEY
Address = 10.5.0.2/32
MTU = 1350
DNS = 103.86.96.100 103.86.99.100

[Peer]
PublicKey = SERVER_PUBKEY
AllowedIPs = 0.0.0.0/0, ::/0
Endpoint = SERVER_IP:51820
PersistentKeepalive = 25
EOF
		fi
	'';

	system.stateVersion = "25.11";

	# Fonts
	fonts.packages = with pkgs; [
		font-awesome
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
		raleway
	];

	# Stylix for theming
	stylix = {
		enable = true;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
		image = ./wallpaper.jpg;
		fonts =  with pkgs; {
			serif = {
				package = dejavu_fonts;
				name = "DejaVu Serif";
			};

			sansSerif = {
				package = dejavu_fonts;
				name = "DejaVu Sans";
			};

			monospace = {
				package = nerd-fonts.jetbrains-mono;
				name = "JetBrains Mono";
			};

		emoji = {
			package = noto-fonts-color-emoji;
			name = "Noto Color Emoji";
		};
		};
		cursor = {
			package = pkgs.adwaita-icon-theme;
			name = "Adwaita";
			size = 24;
		};
	};

}
