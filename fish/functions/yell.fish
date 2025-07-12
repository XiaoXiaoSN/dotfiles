function yell --description "Print a colorful text animation"
    set input_text ""
    if not isatty stdin
        set input_text (cat)
    else if test (count $argv) -gt 0
        set input_text $argv
    else
        echo "  This function converts the input text to uppercase, renders it using 'figlet',"
        echo "  and pipes the result to 'lolcat' with animation effects."
        echo ""
        echo "✨ USAGE:"
        echo "  yell [TEXT...]            # Print the given text in a colorful animation"
        echo "  echo [TEXT...] | yell     # Pipe text into yell for the same effect"
        echo ""
        echo "📌 EXAMPLES:"
        echo "  yell Hello World"
        echo "  echo 'Fish is awesome!' | yell"
        echo ""
        return 1
    end

    echo $input_text | tr [a-z] [A-Z] | figlet | lolcat --freq 0.7 --animate --duration 8 --speed 80
end
