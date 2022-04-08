# Fig post block. Keep at the bottom of this file.
if type -q fig
  eval (fig init fish post | string split0)
end
