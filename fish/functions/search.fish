function search -d 'search in the web'
    if set -q argv[1]
        open "https://www.google.com/search?q=$argv[1]" >/dev/null 2>&1
        return
    end

    # read the search term
    read -p 'set_color ffd787;
            echo -n "Search ";
            set_color 5fd7af;
            echo -n "➜  ";
            set_color normal' search_term
    if test -n "$search_term"
        open "https://www.google.com/search?q=$search_term" >/dev/null 2>&1
    end
end
