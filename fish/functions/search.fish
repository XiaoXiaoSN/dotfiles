function search -d 'search in the web'
    set -l query
    if set -q argv[1]
        set query (string join " " $argv)
    else
        # read the search term
        read -p 'set_color ffd787;
                echo -n "Search ";
                set_color 5fd7af;
                echo -n "➜  ";
                set_color normal' query
    end

    if test -z "$query"
        return
    end

    set -l url "https://www.google.com/search?q=" (string escape --style=url "$query")
    open "$url" >/dev/null 2>&1
end
