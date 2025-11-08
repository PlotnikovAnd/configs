function nvims
    # Список конфигураций
    set items nvchad nv lazy

    # Выбор через fzf
    set config (printf "%s\n" $items | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)

    if test -z "$config"
        echo "Nothing selected"
        return 0
    else if test "$config" = "default"
        set config ""
    end

    # Запуск neovim с нужным именем приложения
    NVIM_APPNAME=$config nvim $argv
end
