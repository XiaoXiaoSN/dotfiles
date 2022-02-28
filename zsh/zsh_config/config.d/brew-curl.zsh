# Hey! Your apple built-in `curl` does not support newest TLS protocol!
# `$ brew install curl`
#
# curl: (35) error:1400442E:SSL routines:CONNECT_CR_SRVR_HELLO:tlsv1 alert protocol version
CURL_PATH=/opt/homebrew/opt/curl/bin
if [ -d "$CURL_PATH" ]; then
    # set and export to sub-processes (make it inherited by child processes)
    path+=($CURL_PATH)
    export PATH
fi
