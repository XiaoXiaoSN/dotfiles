# Install nvm from homebrew.
NVM_FILE_PATH="/opt/homebrew/opt/nvm"

if [ -d "$NVM_FILE_PATH" ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_FILE_PATH/nvm.sh" ] && \. "$NVM_FILE_PATH/nvm.sh"  # This loads nvm
  [ -s "$NVM_FILE_PATH/etc/bash_completion.d/nvm" ] && \. "$NVM_FILE_PATH/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
fi
