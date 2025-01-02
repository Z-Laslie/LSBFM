#!/bin/bash

# BSD NOT SUPPORTED CURRENLY!
# REQUIRED OS: Linux, RECOMMENDED BASH VERSION: around 5 or above

# WIP for things rn, also if i don't put comments in almost E V E R Y T H I N G, i'll get lost :/
# Sat. 16. Nov. (timezone: CET) 23:28: FINALLY DONE WITH THAT!!!!

# Currently decomissioned fail-safe:
# if [[ "$toberemoved" == "/" ]]; then
#	echo -e "${RED}\033[1m;5 NOOOO!!!, don't remove ROOT(/)!!!!!!, dumm dumm!${NORMAL}"
# fi

# Defines Colours in ASCII Escape codes
RED="\033[31m" # colour red
GREEN="\033[32m" # colour green
BLUE="\033[34m" # colour blue
YELLOW="\033[33m" # colour yellow
BYELLOW="\033[33m;2m" # colour yello, but bold/more intensive
LIGHTBLUE="\033[36m" # colour light blue
NORMAL="\033[0m" # resets colour to default
# Bold will be \033[2m and i won't make a separate one for dimmer dark grey italisized too which is: \0033[37;2;3m

# Funtions for select things, simplifying things, and also cases for em'

# Funtion for listing commands, and basically helping
show_help() {
	clear
	echo -e "${YELLOW}Available commands:"
	echo -e "------------------------${NORMAL}"
	echo "H - Shows this dialouge"
	echo -e "T - Engages ${GREEN}'touch'${NORMAL} to make files (type TT for superuser permission)"
	echo "Q - Quits out of script"
	echo -e "M - Engages ${BLUE}'mkdir'${NORMAL} to make directories (type MM for superuser permission)"
	echo -e "R - Engages ${RED}'rm -rf'${NORMAL} to ${RED}forcefully and recursively${NORMAL} remove a dir or file (type RR for superuser permission)"
	echo -e "O - Engages ${LIGHTBLUE}'mv'${NORMAL} to ${LIGHTBLUE}move or rename things${NORMAL} (type OO for superuser permission)"
	echo -e "X - \033[33;1mExecutes${NORMAL} commands outside of already existing choices${NORMAL}"
	echo -e "${YELLOW}------------------------"
	echo -e "\nSome other meaningless stuff:"
	echo -e "------------------------${NORMAL}"
	echo ".dir(s) refer to as hidden directories (e.g: .local), but you also need to specify your exact location and name of dir/file to be done something with!"
	echo "(su) is referred to as superuser, and it is used when the 'superuser permission-ed' commands are used" 
	echo -e "${YELLOW}------------------------${YELLOW}"
}

# Simple quitting
quit() {
	clear
	echo -e "\033[37;2;3m Quitting...${NORMAL}"
}

# Simple directory making + simple detections for: if it exists, if made or not and if typing in blank
makedir() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
	echo -e "Where to make directory? \033[37;2;3m(PATH first and then NAME)${NORMAL}: "
	read -r dir_placename
	if [[ -z "$dir_placename" ]]; then
        echo -e "${RED}You must answer!... no i am not kidding :/${NORMAL}"
        return
	else
        mkdir "$dir_placename"
        echo "${GREEN}Created!${NORMAL}"
	fi

	if [[ -d "$dir_placename" ]]; then
	        echo "${RED}Directory already exists in said place${NORMAL}"
	else
        mkdir "$dir_placename"
        if [[ $? -eq 0 ]]; then
                mkdir "$dir_placename"
	else
        echo "${RED}\033[1mCouldn't make directory :("
        fi
fi
clear
}

# Same as one above, but with sudo ;)
sumakedir() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
	echo "Where to make, what directory? (su) \033[37;2;3m(PATH first and then NAME)${NORMAL}: "
	read -r dir_placename
	if [[ -z "$dir_placename" ]]; then
		echo -e "${RED}You must answer!... no i am not kidding :/${NORMAL}"
		return
	else
		sudo mkdir "$dir_placename"
		echo "\033[32;1mCreated!${NORMAL}"
	fi

	if [[ -d "$dir_placename" ]]; then
		echo "${RED}Directory already exists in said place${NORMAL}"
	else
	        sudo mkdir "$dir_placename"
	fi
	if [[ $? -eq 0 ]]; then
		sudo mkdir "$dir_placename"
	else
		echo "\033[31;1mCouldn't make directory :("
	fi
clear
}
# Yes i know, it is a mess!, i think (so many if-s)

# Removes a dir/file BUT it checks if it exists with an if statement and a variable, to make sure you are not removing... well... nothing
remove() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
	echo -e "What to remove? \033[37;2;3m(PATH first and then NAME)${NORMAL}: "
	read -r toberemoved
	if [[ -z "$toberemoved" ]]; then
		echo -e "${RED}You'd need to answer though, removing nothing is not doing anything!${NORMAL}"
		return
	fi
	if [[ -e "$toberemoved" ]]; then
		rm -rf "$toberemoved"
		if [[ "$?" -eq 0 ]]; then
			echo "${GREEN}Removed!${NORMAL}"
		else
			echo "${RED}\033[2;5mCouldn't remove!${NORMAL}"
		fi
		if [[ ! -e "$toberemoved" ]]; then
			echo "${RED}Directory or File doesn't exist${NORMAL}"
		fi
	fi
clear
}

suremove() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
        echo -e "What to remove\033[37;2;3m(su)${NORMAL}? \033[37;2;3m(PATH first and then NAME)${NORMAL}: "
        read -r toberemoved
	if [[ -z "$toberemoved" ]]; then
        	echo -e "${RED}You'd need to answer though, removing nothing is not doing anything!${NORMAL}"
        	return
	fi
	if [[ -e "$toberemoved" ]]; then
        	sudo rm -rf "$toberemoved"
		if [[ "$?" -eq 0 ]]; then
                	echo "${GREEN}Removed!${NORMAL}"
                else
               	 echo "${RED}\033[2;5mCouldn't remove!${NORMAL}"
		fi
	else
		echo "${RED}Directory or File doesn't exist${NORMAL}"
	fi
	clear
}

# Simple Rename/Move Func.
rennmov() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
	echo -e "What to move/rename?\033[37;2;3m(usage: PATH or/and FILENAME PATH2 or and FILENAME2): "
	read -r renammov renammov2
	if [[ -z "$renammov" || "$renammov2" ]]; then
		echo -e "${RED}Please answer! (usage: PATH/FILENAME PATH2/FILENAME)${NORMAL}"
		return
	fi
	if [[ -e "$renammov" || "$renammov2" ]]; then
		mv "$renammov" "$renammov2"
		if [[ "$?" -eq 0 ]]; then
			echo -e "${GREEN}Successfully moved/renamed!${NORMAL}"
		else
			echo -e "${RED}Rename/move not successful!${NORMAL}" | echo "$?"
		fi
	fi
clear
}

# Same as above (but with sudo)
surennmov() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
	echo -e "What to move/rename?\033[37;2;3m(\033[32;5m(su)\033[37;2;3musage: PATH or/and FILENAME PATH2 or and FILENAME2): "
	read -r renammov renammov2
	if [[ -z "$renammov" || "$renammov2" ]]; then
		echo -e "${RED}Please answer! (usage: PATH/FILENAME PATH2/FILENAME)${NORMAL}"
		return
	fi
	if [[ -e "$renammov" || "$renammov2" ]]; then
		mv "$renammov" "$renammov2"
	if [[ "$?" -eq 0 ]]; then
			echo -e "${GREEN}Successfully moved/renamed!${NORMAL}"
		else
			echo -e "${RED}Rename/move not successful!${NORMAL}" | echo "$?"
		fi
	fi
clear
}

# Makes stuff
touchy() {
	clear
	ls --color=auto
	echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
	echo -e "What to create?\033[37;2;3m(usage: path/to/dir/)${NORMAL}: "
	read -r createplace
	if [[ -z "$createplace" ]]; then
		echo "${RED}Please specify the correct path, and not leave the space empty, thank you!${NORMAL}"
		return
	fi
	if [[ -e "$createplace" ]]; then
		echo "Filename?: "
		read -r filename
		touch "$createplace$filename"
		if [[ "$?" -eq 0 ]]; then
			echo "${GREEN}Successfully created file at path!${NORMAL}"
		else
			echo "${RED}File creation unsuccessful! |" ; echo " $?"
		fi
	fi
}

# You know the drill...
#sutouchy() {
#}
clear
echo "Welcome to Bash filemanager - Alpha"
echo -e "You are here: ${LIGHTBLUE}\033[2m$(pwd)${NORMAL}"
echo "-----------------------------------"
# Shows which working dir you are in, files and waiting to read input

# debugging for input entered, un-comment to enable echo assisted debug (tbh pretty useless, just a debug 4 me to see what is going on)
# echo "Debug: Input='$inputedchar' User='$USER'"

# The "Loop"
while true
do
	echo -e "${NORMAL}"
	ls --color=auto -a
	echo -e "\nWhat would you like to do? (H for help): "
	read -r inputedchar

	case $inputedchar in
	H)
		show_help
		;;
	R)
		remove
		;;
	RR)
		suremove
		;;
	M)
		makedir
		;;
	MM)
		sumakedir
		;;
	Q)
		quit
		exit 0
		;;
	O)
		rennmov
		;;
	OO)
		surennmov
		;;
	T)
		touchy
		;;
#	TT)
#		sutouchy
#		;;
	*)
		echo -e "\033[5;31mInvalid Command (Type H for help)" # As said... H FOR HELP!
		;;
	esac
done
