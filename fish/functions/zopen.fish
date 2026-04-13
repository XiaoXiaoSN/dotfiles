function zopen -d 'open best-matching directory (zoxide first)'
    if type -q zoxide
        set dir (zoxide query $argv[1] 2>/dev/null)
    else if type -q z
        set dir (z -e $argv[1] 2>/dev/null)
    else
        echo "Neither zoxide nor z is installed"
        return 1
    end

    if test -n "$dir"
        open "$dir"
    end
end
