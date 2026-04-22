# Taken from: https://github.com/dideler/dotfiles/blob/master/functions/extract.fish

function x --description "Expand or extract bundled & compressed files"
  set -l file $argv[1]
  if not test -f "$file"
    echo "'$file' is not a valid file"
    return 1
  end

  switch "$file"
    case '*.tar'
      tar --extract --verbose --file "$file"
    case '*.tar.gz' '*.tgz'
      tar --extract --gzip --verbose --file "$file"
    case '*.tar.bz2' '*.tbz2'
      tar --extract --bzip2 --verbose --file "$file"
    case '*.tar.xz' '*.txz'
      tar --extract --xz --verbose --file "$file"
    case '*.gz'
      gunzip "$file"
    case '*.bz2'
      bunzip2 "$file"
    case '*.xz'
      unxz "$file"
    case '*.zip'
      unzip "$file"
    case '*.rar'
      unrar x "$file"
    case '*.7z'
      7z x "$file"
    case '*'
      echo "unknown extension for '$file'"
      return 1
  end
end
