# .bashrc

# User specific environment
#if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
#    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
#fi
#export PATH

# Enable bash programmable completion features in interactive shells
#if [ -f /usr/share/bash-completion/bash_completion ]; then
#	. /usr/share/bash-completion/bash_completion
#elif [ -f /etc/bash_completion ]; then
#	. /etc/bash_completion
#fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#if [ -d ~/.bashrc.d ]; then
#    for rc in ~/.bashrc.d/*; do
#        if [ -f "$rc" ]; then
#            . "$rc"
#        fi
#    done
#fi
#unset rc

# ble.sh start
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

export HISTFILESIZE=10000
export HISTSIZE=500

# don't put duplicate lines in the history and do not add lines that start with a space
export histcontrol=erasedups:ignoredups:ignorespace

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
export EDITOR=nvim
export VISUAL=nvim

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

alias da='date "+%Y-%m-%d %A %T %Z"'

# Alias's to modified commands
alias mkdir='mkdir -p'
alias dnf='sudo dnf'
alias cat='bat'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="history | grep "

# Search files in the current folder
alias f="find . | grep "

# Show open ports
alias openports='netstat -nape --inet'

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# alias's to show disk space and space used in a folder
alias diskspace="du -s | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -cahf --dirsfirst'
alias treed='tree -cafd'
alias mountedinfo='df -ht'

# alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
alias sha1='openssl sha1'

#Clickpaste
clickpaste ()
{
    if [ $# -eq 0 ]; then
        sleep 4; xclip -o -selection clipboard | tr "\n" "\r" | xdotool type --clearmodifiers --delay 500 --file -
    else
        sleep "${1}"; xclip -o -selection clipboard | tr "\n" "\r" | xdotool type --clearmodifiers --delay "${2}" --file -
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

# Searches for text in all files in the current folder
ftext ()
{
	# -i case-insensitive
	# -I ignore binary files
	# -H causes filename to be printed
	# -r recursive search
	# -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Goes up a specified number of directories  (i.e. up 4)
up ()
{
	local d=""
	limit=$1
	for ((i=1 ; i <= limit ; i++))
		do
			d=$d/..
		done
	d=$(echo $d | sed 's/^\///')
	if [ -z "$d" ]; then
		d=..
	fi
	cd $d
}

#Automatically do an ls after each cd
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

# IP address lookup
alias whatismyip="hostname -I"

# Starship
eval "$(/home/linuxbrew/.linuxbrew/bin/starship init bash)"

# Zoxide
eval "$(/home/linuxbrew/.linuxbrew/bin/zoxide init bash --cmd cd)"

# Fnm
eval "$(fnm env --use-on-cd --shell bash)"

# Atuin
eval "$(/home/linuxbrew/.linuxbrew/bin/atuin init bash)"

# Lazy git
gcom() {
	git add .
	git commit -m "$1"
}

# no more rm (unsafe)
alias rm="echo 'use rn'"
alias rn="trash"
alias trash-list="trash list | fzf --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force"
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# vim to nvim
alias vim="nvim"

# GPG SSH

# unset SSH_AGENT_PID
# if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
#   export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
# fi
# export GPG_TTY=$(tty)
# gpg-connect-agent updatestartuptty /bye >/dev/null

# Kitten (kitty)
alias ssh="kitten ssh"

# mutt
alias nmutt="neomutt"

# go
export PATH="$PATH:$HOME/go/bin"

hashsign() {
    if [[ -z "$1" ]]; then
        echo "Usage: shasign <file>"
        return 1
    fi

    local filename="$1"
    local signature_file="$filename.sha256"
    local signed_file="$filename.sha256.sig"

    if [[ ! -f "$filename" ]]; then
        echo "Error: File '$filename' not found."
        return 1
    fi

    echo "Generating SHA256 checksum for '$filename'..."
    if ! sha256sum "$filename" > "$signature_file"; then
        echo "Error: Failed to generate SHA256 checksum."
        return 1
    fi

    echo "Signing '$signature_file'..."
    if ! gpg --clearsign --yes --out "$signed_file" --local-user "aamirmazad@gmail.com" "$signature_file"; then
        echo "Error: Failed to sign the checksum file."
        # Optionally remove the unsigned checksum file on failure
        # rm -f "$signature_file"
        return 1
    fi
    rn -f "$signature_file"
    
    echo "Successfully generated and inline signed '$signed_file'."
}

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - bash)"

# ble.sh end
[[ ! ${BLE_VERSION-} ]] || ble-attach

