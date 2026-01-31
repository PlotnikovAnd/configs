if status is-interactive
	# Init tools
	starship init fish | source 
	zoxide init --cmd cd fish | source
	fzf --fish | source

	# Previews 
	set -x FZF_CTRL_T_OPTS "--preview 'batcat -n --color=always --line-range :500 {}'"
	set -x FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

	# Aliases
	alias cat="batcat"
	alias nv="NVIM_APPNAME=nvchad nvim"

	# Eza config
    alias ls="eza --grid --icons=auto --group-directories-first"
    alias ll="eza --long --all --header --icons=auto --git --group-directories-first --time-style=long-iso --smart-group --octal-permissions"
    alias lt="eza --tree --level=2 --icons=auto" 
	alias lS="eza --long --header --sort=size --reverse --icons=auto"
	# Как ll, но считает размер папок (--total-size) и подсвечивает вес (--color-scale)
	alias lz="eza --long --all --header --icons=auto --git --group-directories-first --time-style=long-iso --smart-group --octal-permissions --total-size --color-scale=size"

	# Path
	fish_add_path ~/bin

	# Zellij (лучше в конце, чтобы environment успел загрузиться)
	eval (zellij setup --generate-auto-start fish | string collect)
end
