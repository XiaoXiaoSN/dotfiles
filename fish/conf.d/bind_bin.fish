# add brew executables in fish path
fish_add_path /opt/homebrew/bin

# add custom executables in fish path
if test -d $HOME/.bin
  fish_add_path $HOME/.bin
end

# Hey! Your apple built-in `curl` does not support newest TLS protocol!
# `$ brew install curl`
#
# curl: (35) error:1400442E:SSL routines:CONNECT_CR_SRVR_HELLO:tlsv1 alert protocol version
set -l CURL_PATH /opt/homebrew/opt/curl/bin
if test -d $CURL_PATH
  # If you need to have curl first in your PATH, run:
  fish_add_path $CURL_PATH

  # For compilers to find curl you may need to set:
  set -gx LDFLAGS "-L/opt/homebrew/opt/curl/lib"
  set -gx CPPFLAGS "-I/opt/homebrew/opt/curl/include"

  # For pkg-config to find curl you may need to set:
  set -gx PKG_CONFIG_PATH "/opt/homebrew/opt/curl/lib/pkgconfig"

  # NOTE: Is it possible to move the completion file to `~/.local/share/fish/vendor_completions.d`?
  # fish completions have been installed to:
  source /opt/homebrew/opt/curl/share/fish/vendor_completions.d/curl.fish
end
