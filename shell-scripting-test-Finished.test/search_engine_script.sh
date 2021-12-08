#!/bin/bash 
source ./Functions/misc.sh
echo '▒█▀▀▀█ ▒█▀▀▀ ░█▀▀█ ▒█▀▀█ ▒█▀▀█ ▒█░▒█ 　 ▒█▀▀▀ ▒█▄░▒█ ▒█▀▀█ ▀█▀ ▒█▄░▒█ ▒█▀▀▀ 
░▀▀▀▄▄ ▒█▀▀▀ ▒█▄▄█ ▒█▄▄▀ ▒█░░░ ▒█▀▀█ 　 ▒█▀▀▀ ▒█▒█▒█ ▒█░▄▄ ▒█░ ▒█▒█▒█ ▒█▀▀▀ 
▒█▄▄▄█ ▒█▄▄▄ ▒█░▒█ ▒█░▒█ ▒█▄▄█ ▒█░▒█ 　 ▒█▄▄▄ ▒█░░▀█ ▒█▄▄█ ▄█▄ ▒█░░▀█ ▒█▄▄▄ 

		▒█▀▀▀█ ▒█▀▀█ ▒█▀▀█ ▀█▀ ▒█▀▀█ ▀▀█▀▀ 
		░▀▀▀▄▄ ▒█░░░ ▒█▄▄▀ ▒█░ ▒█▄▄█ ░▒█░░ 
		▒█▄▄▄█ ▒█▄▄█ ▒█░▒█ ▄█▄ ▒█░░░ ░▒█░░'
TYPE_SEARCH=""
echo 'WHAT WOULD YOU LIKE TO FIND?
	1:file
	2:Process
	3:Exit'
read TYPE_SEARCH

NUMBER='^[0-9]+$'


while [[ $TYPE_SEARCH  -le 0 ]] || [[ $TYPE_SEARCH -ge 4 ]] || ! [[ "$TYPE_SEARCH" =~ $NUMBER ]];
do 

	TYPE_SEARCH=""
    echo 'Invalid input, please try again.'
    read TYPE_SEARCH
    if  [[ $TYPE_SEARCH -le  3 && $TYPE_SEARCH -ge 1 ]]
    then 
		break
    fi
done

case $TYPE_SEARCH in

	1) 
		file_function
	;;
	2)
		process_function
	;;	

	3)
		echo 'Goodbye!'
	;;

esac
exit	

 



