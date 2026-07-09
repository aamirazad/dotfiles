source /usr/share/cachyos-fish-config/cachyos-config.fish

export PATH="$HOME/.local/bin:$PATH"

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# pnpm
set -gx PNPM_HOME "/home/aamir/.local/share/pnpm"
if not string match -q -- "$PNPM_HOME/bin" $PATH
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end

# fnm
set FNM_PATH "/home/aamir/.local/share/fnm"
if [ -d "$FNM_PATH" ]
  set PATH "$FNM_PATH" $PATH
  fnm env --shell fish | source
end



# Added by Antigravity CLI installer
set -gx PATH "/home/aamir/.local/bin" $PATH

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/aamir/.lmstudio/bin
# End of LM Studio CLI section


# Pi
fish_add_path "/home/aamir/.local/share/fnm/node-versions/v24.15.0/installation/bin"

# opencode
fish_add_path /home/aamir/.opencode/bin

