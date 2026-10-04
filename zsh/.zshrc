# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt nomatch
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mariner/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# CUSTOM

unsetopt BEEP
# .files are not hidden in tab completion
setopt globdots

# alt-delete doesn't delete entire path
autoload -U select-word-style
select-word-style bash

# verbose ls w/out . & .. # DOES NOT WORK ON MAC/POSSIBLY WIN
# alias ls="ls --color=auto -lahF -I '.' -I '..'"

alias ls="ls --color=auto -lahF"

# Note ; 'n' to list all notes, 'n [file]' to travel there
function n() {

	if [ $# -eq 0 ]; then # if n by itself
		echo "Please select a note with n [note]"
		ls ~/Notes/vim/*.txt | cut -d "/" -f 6 | cut -d "." -f 1
	else
		nvim ~/Notes/vim/"$1".txt
	fi
}

# Search Note ; 'sn' [match] to search your stack of notes
function sn() {
	
	# Yank the paragraph(s) of a match
	awk -v RS='' "/$1/" ~/Notes/vim/*.txt
}

# Quick Note ; 'qn' to write to the bucket, 'qn [file]' to the file
function qn() {

	mkdir -p ~/Notes/vim

	echo "Conclude your input with C-d C-d"  
	text=$(cat)
	printf '%s \n\n' "$text" | fold -w 80 -s >~/Notes/vim/tmp

	if [ $# -eq 1 ]; then
		touch ~/Notes/vim/"$1".txt
		mv ~/Notes/vim/$1.txt ~/Notes/vim/$1.bak
		cat ~/Notes/vim/tmp ~/Notes/vim/$1.bak >~/Notes/vim/$1.txt

	else
		touch ~/Notes/vim/bucket.txt
		mv ~/Notes/vim/bucket.txt ~/Notes/vim/bucket.bak
		cat ~/Notes/vim/tmp ~/Notes/vim/bucket.bak >~/Notes/vim/bucket.txt
	fi

	# clean input
	echo ""
}
