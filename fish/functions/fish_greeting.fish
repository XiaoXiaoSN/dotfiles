function part1
  echo ""
  echo "            *      ,8MMM8&&&.             *"
  echo "                  MMMM888&&&&&    .        "
  echo "                 MMMM88&&&&&&&M            "
  echo "     *           MMM88&&&&&&&&M            "
  echo "                 MMM88&&&&&&&&M            "
  echo "                 'MMM88&&&&&&M'            "
  echo "                  '.MM8&&&&M.\"      *     "
end

function part2
  echo "          |\\___/|     /\\___/\\"
  echo "          )     (     )     ( .              '"
  echo "         =\\     /=   =\\     /="
  echo "           )===(       )   ("
  echo "          /     \\     /     \\"
  echo "          |     |     )     ("
  echo "         /       \\   /       \\"
  echo "         \\       /   \\       /"
  echo "     _/\\_/\\__  _/_/\\_/\\__ __/_/\\_/\\_/\\_/\\_/\\_/\\_/\\_"
  echo "  |  |  |  |( (  |  |  | ))  |  |  |  |  |  |  |  |"
  echo "  |  |  |  | ) ) |  |  |//|  |  |  |  |  |  |  |  |"
  echo "  |  |  |  |(_(  |  |  (( |  |  |  |  |  |  |  |  |"
  echo "  |  |  |  |  |  |  |  |\\)|  |  |  |  |  |  |  |  |"
  echo "  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |"
end

function fish_greeting
  # try to choose the faster lolcat
  set lolcat_cmd
  if command -q $HOME/.cargo/bin/lolcat
      # cargo lolcat is faster than the original ruby lolcat 100x times
      # installation: cargo install lolcat
      set lolcat_cmd $HOME/.cargo/bin/lolcat --frequency 0.13
  else if command -q lolcat
      set lolcat_cmd lolcat --freq 0.13
  end

  # use `lolcat` to display the moon in part1
  if test -n "$lolcat_cmd"
      part1 | $lolcat_cmd --frequency 0.13
  else
      part1
  end
  # display the cats in part2
  part2
end
