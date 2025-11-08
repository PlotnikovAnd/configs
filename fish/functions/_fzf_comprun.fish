function _fzf_comprun
    set command $argv[1]
    set -e argv[1]

    switch "$command"
        case cd
            fzf --preview 'eza --tree --color=always {} | head -200' $argv
        case export unset
            fzf --preview "eval 'echo \$' {}"
        case ssh
            fzf --preview 'dig {}' $argv
        case '*'
            fz --preview 'batcat -n --color=always --line-range :500 {}' $argv
    end
end
