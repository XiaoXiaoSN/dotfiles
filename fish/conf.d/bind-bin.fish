# add brew binaries in fish path
fish_add_path /opt/homebrew/bin

if test -d $HOME/.bin
  fish_add_path $HOME/.bin
end
