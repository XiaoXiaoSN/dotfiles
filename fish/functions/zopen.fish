function zopen -d 'open directory which best matching'
    z -e $argv[1]
    if [ $status -eq 0 ]
        open (z -e $argv[1])
    end
end
