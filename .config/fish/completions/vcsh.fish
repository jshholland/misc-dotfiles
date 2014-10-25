complete -c vcsh -a 'commit help list list-tracked pull push version clone which init'
complete -c vcsh -a 'delete enter list-tracked-by rename run upgrade write-gitignore'
complete -c vcsh -s v -d 'Enable verbose mode'
complete -c vcsh -s d -d 'Enable debug mode'

for repo in (vcsh list)
	complete -c vcsh -a $repo
end
