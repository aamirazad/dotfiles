# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
ZSH=/home/aamira/.oh-my-zsh

# Path to powerlevel10k theme
source ~/powerlevel10k/powerlevel10k.zsh-theme

# List of plugins used
plugins=(
    zsh-autosuggestions
)
source $ZSH/oh-my-zsh.sh

# Zsh autosuggest
ZSH_AUTOSUGGEST_STRATEGY=(completion history)
bindkey '^o' forward-word

# # In case a command is not found, try to find the package that has it
# function command_not_found_handler {
#     local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
#     printf 'zsh: command not found: %s\n' "$1"
#     local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
#     if (( ${#entries[@]} )) ; then
#         printf "${bright}$1${reset} may be found in the following packages:\n"
#         local pkg
#         for entry in "${entries[@]}" ; do
#             local fields=( ${(0)entry} )
#             if [[ "$pkg" != "${fields[2]}" ]] ; then
#                 printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
#             fi
#             printf '    /%s\n' "${fields[4]}"
#             pkg="${fields[2]}"
#         done
#     fi
#     return 127
# }

# Helpful aliases
alias  l='eza -lh  --icons=auto' # long list
alias ls='eza --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Display Pokemon
# pokemon-colorscripts --no-title -r 1,3,6

#  █████╗ ██╗     ██╗ █████╗ ███████╗███████╗███████╗
# ██╔══██╗██║     ██║██╔══██╗██╔════╝██╔════╝██╔════╝
# ███████║██║     ██║███████║███████╗█████╗  ███████╗
# ██╔══██║██║     ██║██╔══██║╚════██║██╔══╝  ╚════██║
# ██║  ██║███████╗██║██║  ██║███████║███████╗███████║
# ╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝                                         

#alias ssh="kitten ssh"
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'

## APPS

# nobara updater

alias update-system="sudo dnf update rpmfusion-nonfree-release rpmfusion-free-release fedora-repos nobara-repos --refresh && sudo dnf distro-sync --refresh && sudo dnf update --refresh"

# fnm
export PATH="/home/aamira/.local/share/fnm:$PATH"
eval "`fnm env`"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# Fahcontrol

alias fahcontrol="python2 /usr/bin/FAHControl"

## Gh copilot cli
eval "$(gh copilot alias -- zsh)"

## Clickpaste

clickpaste()
{
    if [ $# -eq 0 ]; then
        sleep 4; xclip -o -selection clipboard | tr "\n" "\r" | xdotool type --clearmodifiers --delay 500 --file -
    else
        sleep "${1}"; xclip -o -selection clipboard | tr "\n" "\r" | xdotool type --clearmodifiers --delay "${2}" --file -
    fi
}


# ███████╗███╗   ██╗██╗   ██╗
# ██╔════╝████╗  ██║██║   ██║
# █████╗  ██╔██╗ ██║██║   ██║
# ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝
# ███████╗██║ ╚████║ ╚████╔╝ 
# ╚══════╝╚═╝  ╚═══╝  ╚═══╝  
                           
export EDITOR="nvim"
#Automatically do an ls after each cd
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in "$@"; do
		if [ -f "$archive" ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Image optimizer

optimg() {
    pngquant -v --ext .png --force --skip-if-larger --strip --speed 1 --quality 80-90 "$@"
}


export PATH=$PATH:/usr/local/go/bin

# Jonny desimal command line

cdj() {

  # Update with your document root folder
  pushd ~/Vault/*/*/${1}*

}

export cdj

# zoxide

eval "$(zoxide init --cmd cd zsh)"

# ranger

alias ranger='ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'

# pyenv

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# poetry

export PATH="/home/aamira/.local/bin:$PATH"

# bun completions
[ -s "/home/aamira/.bun/_bun" ] && source "/home/aamira/.bun/_bun"

# fnm
FNM_PATH="/home/aamira/.fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/aamira/.fnm:$PATH"
  eval "`fnm env`"
fi

export PATH=$PATH:/home/aamira/.local/bin

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
