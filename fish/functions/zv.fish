function zv -d 'use NeoVim open directory which best matching'
  z -e $argv[1]
  if [ $status -eq 0 ]
    nvim (z -e $argv[1])
  end
end
