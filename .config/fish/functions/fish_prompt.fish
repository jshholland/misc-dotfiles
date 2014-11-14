function fish_prompt
	set st $status
	if [ $st -ne 0 ]
		set_color $fish_color_error
		echo -n $st
		set_color normal
		echo -n ' '
	end
	echo -n (whoami)
	echo -n '@'
	echo -n (hostname)
	echo -n ' '
	set_color $fish_color_cwd
	echo -n (prompt_pwd)
	set_color normal
	echo -n '> '
end
