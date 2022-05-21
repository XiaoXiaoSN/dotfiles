# for linux in "$HOME/.nvm"
# for old version macOS, brew install in "/usr/local/opt/nvm"
NVM_INSTALL_PATH="/opt/homebrew/opt/nvm"

if [ -d "$NVM_INSTALL_PATH" ]; then
  # You can set $NVM_DIR to any location, but leaving it unchanged from
  # /usr/local/opt/nvm will destroy any nvm-installed Node installations
  # upon upgrade/reinstall.
  export NVM_DIR="$HOME/.config/nvm"

  # You should create NVM's working directory if it doesn't exist:
  if [ ! -d "$NVM_DIR" ]; then
    echo "🛠  NVM_DIR: $NVM_DIR not exist. create it now"
    mkdir -p $NVM_DIR
  fi

  # This loads nvm
  # Note: You can add --no-use to the end of the above script (...nvm.sh --no-use)
  # to postpone using nvm until you manually use it.
  [ -s "$NVM_INSTALL_PATH/nvm.sh" ] && \. "$NVM_INSTALL_PATH/nvm.sh" --no-use

  # This loads nvm bash_completion
  [ -s "$NVM_INSTALL_PATH/etc/bash_completion.d/nvm" ] && \. "$NVM_INSTALL_PATH/etc/bash_completion.d/nvm"

  # _sukka_lazyload_command_nvm() {
  #   # This loads nvm
  #   # Note: You can add --no-use to the end of the above script (...nvm.sh --no-use)
  #   # to postpone using nvm until you manually use it.
  #   [ -s "$NVM_INSTALL_PATH/nvm.sh" ] && \. "$NVM_INSTALL_PATH/nvm.sh"
  # }
  #
  # _sukka_lazyload_completion_nvm() {
  #   # This loads nvm bash_completion
  #   [ -s "$NVM_INSTALL_PATH/etc/bash_completion.d/nvm" ] && \. "$NVM_INSTALL_PATH/etc/bash_completion.d/nvm"
  # }
  #
  # sukka_lazyload_add_command nvm yarn npm node
  # sukka_lazyload_add_completion nvm
fi
