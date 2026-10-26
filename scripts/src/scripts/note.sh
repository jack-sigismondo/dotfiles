#!/bin/sh
# Call rofi and vimwiki to write/access notes

# I don't know if || exit 0 is necessary but may as well include it.

note_type=$( # Good idea to keep a unique char in each i.e. Q for Quicknote. TODO (Q)uickNote
	printf "QuickNote\nQuickCan\nGotoNote\nSearchNote\nSearchTag" | rofi -dmenu -i -p "Select note function:") || exit 0

case "$note_type" in
	"QuickNote")
		# Take tags and :surround: :them:, take input and write it underneath.
		# \n in user input really does add newlines.

		# GOT THE SED FROM THE INTERNET NOT SURE HOW IT WORKS.
		tags=$(rofi -dmenu -i -p "Enter Tag(s):" < /dev/null | sed 's/[^[:space:]]*/:&:/g' || exit 0)
		qn_input=$(rofi -dmenu -p "QuickNote Entry:" < /dev/null || exit 0)
		vim "$HOME/Notes/vimwiki/bucket.md" -c "call feedkeys(\"ggjo$tags\<CR>$qn_input\<CR>\<Esc>:wq\<CR>\", 'n')"
		;;

	"QuickCan")
		# Paste your garbage in the can
		qc_input=$(rofi -dmenu -p "QuickCan Entry:" < /dev/null || exit 0)
		vim "$HOME/Notes/vimwiki/can.md" -c "call feedkeys(\"ggjo$qc_input\<CR>\<Esc>:wq\<CR>\", 'n')"
		;;

	"GotoNote")
		# Take a note and open it in a new window.
		# Created window is titled 'vimwiki-s'
		file=$(find "$HOME/Notes/vimwiki" -type f -iregex ".*\.md$" -not -name '*.txt' -printf "%f\n"| sed 's/\.md$//1' | rofi -dmenu -l 10 -i -p "Enter Note:") || exit 0
		kitty --title vimwiki-s nvim "$HOME/Notes/vimwiki/index.md" -c "VimwikiGoto $file"
		echo "$file"
		;;

	"SearchNote")
		# Search a phrase across all notes in a new window.
		# Created window is titled 'vimwiki-s'
		sn_input=$(rofi -dmenu -p "Search for:" < /dev/null || exit 0)
		kitty --title vimwiki-s nvim "$HOME/Notes/vimwiki/index.md" -c "VimwikiSearch $sn_input"
		;;

	"SearchTag")
		# Search a phrase across all notes in a new window.
		# Created window is titled 'vimwiki-s'
		st_input=$(rofi -dmenu -p "Search tag:" < /dev/null || exit 0)
		kitty --title vimwiki-s nvim "$HOME/Notes/vimwiki/index.md" -c "VimwikiSearchTags $st_input"
		;;
esac
