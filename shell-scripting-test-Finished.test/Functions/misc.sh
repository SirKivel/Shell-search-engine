function file_function () {
    source ./Functions/Functions.sh
    echo 'Choose the number for the parameter of your search'
	FILE_TYPE_SEARCH=""
	NUMBER='^[0-9]+$'
	echo '1:name, 2:creation date,  3:file extension, 4:directory' 
	read  FILE_TYPE_SEARCH
    
	while [[ $FILE_TYPE_SEARCH -le 0 ]] || [[ $FILE_TYPE_SEARCH -ge 5 ]] || ! [[ $FILE_TYPE_SEARCH =~ $NUMBER ]];
		do 
			echo 'Invalid input, please try again.'
			read FILE_TYPE_SEARCH
			if  [ $FILE_TYPE_SEARCH -le 4 ]  && [ $FILE_TYPE_SEARCH -ge 1 ]
			then 
				break
			fi
		done
        
	case $FILE_TYPE_SEARCH in
    #FINDING FILE BY NAME
			1) 
                finding_file_by_name
			;;
    #FINDING FILE BY CREATION DATE
			2)	
                finding_file_by_date
			;;		
    #FINDING FILE BY EXTENSION

			3)
				finding_file_by_ext
			;;			
    #FINDING FILE BY DIRECTORY
			4)
				finding_file_by_dir
			;;	
		esac ;}

function process_function () {
     source ./Functions/Functions.sh
     echo 'Choose the number for the parameter of your search'

    PROCESS_TYPE_SEARCH=""

    echo '1:Name, 2:Id,  3:Port, 4:Exit' 
    read PROCESS_TYPE_SEARCH
    #INPUT VALIDATION
    NUMBER='^[0-9]+$'
    while [[ "$PROCESS_TYPE_SEARCH" -le 0 ]] || [[ "$PROCESS_TYPE_SEARCH" -ge 5 ]] || ! [[ "$PROCESS_TYPE_SEARCH" =~ $NUMBER ]];
    do     
	    PROCESS_TYPE_SEARCH=""
        echo 'Invalid input, please try again.'
        read PROCESS_TYPE_SEARCH
        if  [[ "$PROCESS_TYPE_SEARCH" -le 4 && "$PROCESS_TYPE_SEARCH" -ge 1 ]] 
        then break
        fi
    done        

    case $PROCESS_TYPE_SEARCH in
    #FIND PROCESS BY NAME
        1) 
            finding_process_by_name
        ;;
    #FIND PROCESS BY PID   
        2)
            finding_process_by_id
        ;;
    #FIND PROCESS BY PORT
        3) 
           finding_process_by_port
        ;;
        4) 
            echo "Goodbye!"
            exit
        ;;
    esac; }


