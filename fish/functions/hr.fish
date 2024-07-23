# ref: https://github.com/LuRsT/hr

function hr --description "Print a horizontal line"
    set DEFAULT_SYMBOL '-'
    set -x COLS (tput cols)

    if test $COLS -le 0
        set COLS $COLUMNS
        if not set -q COLS
            set COLS 80
        end
    end

    function _hr
        set -l WORD $argv[1]
        if test -z "$WORD"
            return
        end

        set -l LINE (printf "%*s" $COLS)
        set -l LINE (string replace --all ' ' $WORD "$LINE")
        echo (string sub --length $COLUMNS -- "$LINE")
    end

    function _hrs
        for WORD in $argv
            _hr $WORD
        end
    end

    if count $argv > 0
        _hrs $argv
    else
        _hrs $DEFAULT_SYMBOL
    end
end
