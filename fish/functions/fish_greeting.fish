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
  # echo $USER | tr [a-z] [A-Z] | figlet | lolcat -F 0.7 -a -d 8 -s 80
  if command -q lolcat
    part1 | lolcat -F 0.13
  else
    part1
  end

  part2
end
