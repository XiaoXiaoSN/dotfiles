function zc -d 'Use Editor to open directory which best matches'
    set editor "cursor"

    z -e $argv[1]
    if [ $status -eq 0 ]
        set dir (z -e $argv[1])
        if [ "$editor" = "cursor" ]
            cursor $dir
        else
            code $dir
        end
    end
end
