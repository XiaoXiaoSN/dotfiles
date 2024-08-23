# reference: https://direnv.net/docs/hook.html#fish
if command -q direnv
  direnv hook fish | source
end
