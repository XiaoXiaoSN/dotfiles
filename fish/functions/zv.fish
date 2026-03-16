function zv -d 'use Neovim to open best-matching directory (zoxide first)'
    if type -q zoxide
        if test (count $argv) -eq 0
            set dir (zoxide query -i)
        else
            set dir (zoxide query $argv[1] 2>/dev/null)
        end
    else if type -q z
        set dir (z -e $argv[1] 2>/dev/null)
    else
        echo "Neither zoxide nor z is installed"
        return 1
    end

    if test -n "$dir"
        nvim "$dir"
    end
end
