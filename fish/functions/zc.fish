function zc -d 'Use editor to open best-matching directory (zoxide first)'
    set editor code

    if type -q zoxide
        set dir (zoxide query $argv[1] 2>/dev/null)
    else if type -q z
        set dir (z -e $argv[1] 2>/dev/null)
    else
        echo "Neither zoxide nor z is installed"
        return 1
    end

    if test -z "$dir"
        return 1
    end

    switch $editor
        case antigravity
            antigravity "$dir"
        case code
            code "$dir"
        case cursor
            cursor "$dir"
        case '*'
            $editor "$dir"
    end
end
