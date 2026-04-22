# Path to  oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

DISABLE_AUTO_UPDATE="true"

# # Smarter completion initialization
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Theme
ZSH_THEME="af-magic"

zstyle ':completion:*' list-style one-line 
zstyle ':omz:plugins:nvm' lazy yes

# Fix annoying zsh default behavior
unset LESS

# Plugins
plugins=(
	git
	nvm
	zsh-autosuggestions
	sudo
	web-search
	copybuffer
	dirhistory
	history
	zsh-interactive-cd
)

source $ZSH/oh-my-zsh.sh

# ----------------------------- User configuration ----------------------------- #
alias l='ls -lah'
alias xc="xclip -sel clip"
alias te="trans --from swedish --to english -j"
alias ts="trans --from english --to swedish -j"
alias gu='git add .; git commit -m "Update - $(date)"; git push'
alias gs="git status"
alias vpn-on="nmcli connection up skymill_vpn"
alias vpn-off="nmcli connection down skymill_vpn"
alias gitcon="git diff --name-only --diff-filter=U --relative"
alias lgit="git"
alias gl="git log --oneline"
alias rmf="\rm -rf"
alias rm="trash"
alias vim="nvim"
alias r="ranger"
alias dockp="echo Docker port mapping: HOST:CONTAINER"
alias k=kubectl
alias dp="dunst-pause"
alias dr="dunst-resume"
alias icanhasip="curl ipv4.icanhazip.com"
alias rsync="rsync -ravhP" # recursive, archive, verbose, human-readable, progress (and partial)
alias cat="bat"
alias fd="fd -H" # include hidden files by default

# function to open using xdg-open and disown the process
function open() {
  xdg-open "$1" &>/dev/null & disown
}

# kitty ssh fix
[[ "$TERM" == "xterm-kitty" ]] && alias ssh="TERM=xterm-256color ssh" 

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/jazz/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# zoxide
eval "$(zoxide init --cmd cd zsh)"
# zoxide end


# opencode
export PATH=/home/jazz/.opencode/bin:$PATH
