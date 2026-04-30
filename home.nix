{ config, pkgs, pkgs-unstable, ... }:

{
	home.username = "jazz";
	home.homeDirectory = "/home/jazz";
	home.stateVersion = "25.11";

	home.file."scripts".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/scripts";
	# home.file.".config/i3".source = ./i3;
	home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nvim";
	home.file.".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/kitty";
	home.file.".config/hypr".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/hypr";
	home.file.".config/waybar".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/waybar";

	# Mako for notifications
	services.mako.enable = true;

	# User packages
	home.packages = with pkgs; [
		# Personal tools
		neovim
		kitty
		firefox
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
		xclip
		libnotify
		hyprpolkitagent

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

		# Dev tools
		nodejs_24
		yarn
		pnpm
		go
		pkgs-unstable.opencode
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
			xc="xclip -sel clip";
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
}
