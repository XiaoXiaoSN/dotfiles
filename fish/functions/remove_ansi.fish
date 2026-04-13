function remove_ansi -d 'remove ANSI escape codes from a file'
    if test (count $argv) -ne 2
        echo "Usage: remove_ansi <input_file> <output_file>"
        return 1
    end

    set input $argv[1]
    set output $argv[2]

    if not test -f "$input"
        echo "Input file not found: $input"
        return 1
    end

    # remove ANSI CSI sequences
    sed -E 's/\x1B\[[0-9;]*[mK]//g' "$input" > "$output"
end
