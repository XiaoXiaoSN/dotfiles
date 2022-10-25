# reference: https://direnv.net/docs/hook.html#fish
if type -q direnv
  direnv hook fish | source
end
