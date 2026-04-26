{ config, pkgs, ... }:

{
	home.username = "jazz";
	home.homeDirectory = "/home/jazz";
	home.stateVersion = "25.11";

	home.file."scripts".source = ./scripts;
	# home.file.".config/i3".source = ./i3;
	home.file.".config/nvim".source = ./nvim;
	home.file.".config/kitty".source = ./kitty;
	# home.file.".config/polybar".source = ./polybar;

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
			gl="git log --oneline";
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
			nixsw="sudo nixos-rebuild switch --flake ~/.dotfiles";
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
}
