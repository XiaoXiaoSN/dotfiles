zc() {
  z -e $argv[1]
  if [ $status -eq 0 ]; then
    code $(z -e $argv[1])
  fi
}

zv() {
  z -e $argv[1]
  if [ $status -eq 0 ]; then
    vim $(z -e $argv[1])
  fi
}

zopen() {
  z -e $argv[1]
  if [ $status -eq 0 ]; then
    open $(z -e $argv[1])
  fi
}
