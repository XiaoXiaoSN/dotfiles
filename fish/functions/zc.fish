function zc -d 'use VSCode to open directory which best matching'
	z -e $argv[1]
	if [ $status -eq 0 ]
		code (z -e $argv[1])
	end
end
