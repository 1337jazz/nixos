{ config, pkgs, pkgs-unstable, stylix, ... }:

{
	stylix.targets.waybar.enable = false;

	home.username = "jazz";
	home.homeDirectory = "/home/jazz";
	home.stateVersion = "25.11";

	home.file."scripts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/scripts";
	home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/nvim";
	home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/kitty";
	home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/hypr";
	home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/waybar";

	# Mako for notifications
	services.mako.enable = true;

	# Syncthing
	services.syncthing.enable = true;

	# User packages
	home.packages = with pkgs; [
		# Personal tools
		neovim
		kitty
		firefox
		brave
		fastfetch
		ranger
		trash-cli

		# Wayland / desktop
		nwg-displays
		wofi
		brightnessctl
		pavucontrol
		alsa-utils
		playerctl
		libnotify
		hyprpolkitagent
		swaybg

		# CLI utilities
		atool
		unzip
		bat
		tree
		fd
		fzf
		jq
		translate-shell
		bluetui
		btop
		android-tools
		iperf3
		lf

		# Dev tools
		nodejs_24
		yarn
		pnpm
		go
		dotnet-sdk_10
		pkgs-unstable.opencode
		bruno
	];

	programs.git = {
		enable = true;
		settings.user = {
			name  = "Jazz Singh";
			email = "github.compile498@passmail.com";
		};
	  };

	programs.zsh = {
		enable = true;
  		autosuggestion.enable = true;
		shellAliases = {
			l="ls -lah";
			xc="wl-copy";
			te="trans --from swedish --to english -j";
			ts="trans --from english --to swedish -j";
			gu="git add .; git commit -m \"Update - $(date)\"; git push";
			gs="git status";
			vpn-on="nmcli connection up skymill_vpn";
			vpn-off="nmcli connection down skymill_vpn";
			gitcon="git diff --name-only --diff-filter=U --relative";
			lgit="git";
			gl="git --no-pager log --oneline";
			rmf="\rm -rf";
			rm="trash";
			vim="nvim";
			r="ranger";
			dockp="echo Docker port mapping: HOST:CONTAINER";
			k="kubectl";
			dp="dunst-pause";
			dr="dunst-resume";
			icanhasip="curl ipv4.icanhazip.com";
			rsync="rsync -ravhP"; # recursive, archive, verbose, human-readable, progress (and partial)
			cat="bat";
			fd="fd -H"; # include hidden files by default
			nu="sudo nixos-rebuild switch --flake ~/.dotfiles";
		};
		oh-my-zsh = {
			enable = true;
			plugins = [
				"git"
				"nvm"
				"sudo"
				"copybuffer"
				"dirhistory"
				"history"
				"zsh-interactive-cd"
			];
			theme = "af-magic";
		};

		initContent = ''
  			[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh"
		'';
	};

	programs.waybar.enable = true;

	# SSH config - manually add ssh keys!
	programs.ssh = {
		enable = true;
		extraConfig = "
	  	Host kevin 
			Hostname 192.168.0.151
			User jazz
		";
	};

	programs.zoxide = {
		enable = true;
		enableFishIntegration = true;
		options = [
			"--cmd cd"
		];
	};

}
