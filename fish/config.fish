if status is-interactive
    # Commands to run in interactive sessions can go here
	fzf --fish | source
	# fzf preview settings
	set -x FZF_CTRL_T_OPTS "--preview 'batcat -n --color=always --line-range :500 {}'"
	set -x FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

	alias ls="eza --oneline --color=always --all --no-permissions --group --git --no-filesize --icons=always"
	alias ll="eza --oneline --color=always --all --long --no-user --time-style=long-iso --total-size --group-directories-first"
	alias cat="batcat"
	alias nv="NVIM_APPNAME=nvchad nvim"
	starship init fish | source 
	eval (zellij setup --generate-auto-start fish | string collect)
	zoxide init --cmd cd fish | source
	fish_add_path ~/bin
end
