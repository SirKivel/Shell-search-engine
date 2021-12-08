
 function Validating_input () {

    while [[  $WT_DO -le 0 ]] || [[  $WT_DO  -ge 7 ]] || ! [[ $WT_DO =~ $NUMBER ]];
	do 
		echo 'Invalid input, please try again.'
		WT_DO="" && read WT_DO
		if  [[  $WT_DO -le 6 ]] && [[  $WT_DO  -ge 1 ]]
		then break
		fi
    done }


 function finding_file_by_name () {
	cd ~
	NAME="" 
	echo 'Please enter the name of the file that you want to find.'
	read NAME
	FILE_NUMBER=""
	declare -a NAME_ARRAY=(`find -name "*${NAME}*"`)

	#VALIDATING EXISTENCE OF FILE

	while [ "${#NAME_ARRAY[@]}" -eq 0 ]; 
	do
		NAME="" 
		echo 'Unable to find a file with this name.'
		echo 'Please enter the name of the file that you want to find.'
		read NAME
		declare -a NAME_ARRAY=(`find -name "*${NAME}*"`)
		if 	[ "${#NAME_ARRAY[@]}" -ne 0 ]
		then 
			break
		fi
	done

	for i in "${!NAME_ARRAY[@]}"; 
	do 
	printf "%s\t%s\n" "$i" "${NAME_ARRAY[$i]}"
	done

	echo 'Choose the file number that you want to work with'
	read FILE_NUMBER
	F_PATH1=` echo ${NAME_ARRAY[$FILE_NUMBER]}`
	#CHANGING DIRECTORY TO ABSOLUTE


	F_PATH=` echo $(realpath "$F_PATH1")`
	stat $F_PATH
	HOME_DIRECTORY=`pwd`
	echo 'What do you want to do with the file?'

	echo '1:Edit | 2:Delete | 3:Move | 4:Copy to current directory | 5:Show content | 6:Exit '
	#WHAT (W) TO (T) DO
	WT_DO=""
	read WT_DO

	#VALIDATING INPUT
	Validating_input 

	#EXCUTING CHOSEN OPERATION 
	case $WT_DO in 
		1)
			nano ${F_PATH} 
		;;

		2)   
			rm ${F_PATH}  
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully removed'
			else 
				echo 'The file was not removed'
			fi
		;;

		3)
				
			DIRECTORY="" && echo 'Please introduce the Directory that you want to move the file to:' 
			read DIRECTORY
			mv ${F_PATH} ${DIRECTORY}
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully moved'
			else 
				echo 'The file was not moved'
			fi
		;;

		4)
			echo $HOME_DIRECTORY
			cp ${F_PATH} ${HOME_DIRECTORY} 
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully copied.'
			else 
				echo 'The file was not copied'
			fi
		;;

		5)
			cat $F_PATH  
		;;

		6)
			echo 'Goodbye!' 
		;;

	esac }

 function finding_file_by_date () {
	cd ~
	echo 'Please introduce the creation date of the File (Numbers):'
	echo 'YEAR'
	YEAR=""
	read YEAR
	echo 'MONTH'
	MONTH=""
	read MONTH
	echo 'DAY'
	DAY=""
	read DAY
	echo "searching..."
	DAY2=$(($DAY-1))

	#CREATING DATE ARRAY AND CONFIRMING EXISTENCE

	declare -a DATE_ARR=(`find -type f -newermt $YEAR-$MONTH-$DAY2 ! -newermt $YEAR-$MONTH-$DAY`)

	while [ "${#DATE_ARR[@]}" -eq 0 ]; 
	do
		YEAR="" && MONTH="" && DAY="" && DAY2=""
		echo 'Unable to find a file created on this date'
		echo 'Please introduce the creation date of the File (Numbers):'
		echo 'YEAR' && read YEAR 
		echo 'MONTH' && read MONTH 
		echo 'DAY' && read DAY
		DAY2=$(($DAY-1))
		declare -a DATE_ARR=(`find -type f -newermt $YEAR-$MONTH-$DAY2 ! -newermt $YEAR-$MONTH-$DAY`)
		if 	[ "${#DATE_ARR[@]}" -ne 0 ]
		then 
			break
		fi
	done

	#PRINTING ENTIRE ARRAY TO CHOOSE FILE

	for i in "${!DATE_ARR[@]}"; 
	do 
		printf "%s\t%s\n" "$i" "${DATE_ARR[$i]}"
	done

	echo 'Choose the file number that you want to work with'
	FILE_NUMBER="" && read FILE_NUMBER
	F_PATH1=` echo ${DATE_ARR[$FILE_NUMBER]}`
	F_PATH=` echo $(realpath "$F_PATH1")`
	stat $F_PATH
	MY_DIRECTORY=`pwd`
	echo 'What do you want to do with the file?'
	WT_DO=""
	echo '1:Edit | 2:Delete | 3:Move | 4:Copy to current directory | 5:Show content | 6:Exit '
	read WT_DO

	#INPUT VALIDATION
	Validating_input

	#EXCUTING CHOSEN OPERATION 
	
	case $WT_DO in

		1)
			nano ${F_PATH} 
		;;

		2)   
			rm ${F_PATH} 
				
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully removed'
			else 
				echo 'The file was not removed'
			fi
		;;

		3)
				
			DIRECTORY2="" && echo 'Please introduce the Directory that you want to move the file to:' 
			read DIRECTORY2
			mv ${F_PATH} ${DIRECTORY2}
		
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully moved'
			else 
				echo 'The file was not moved'
			fi
		;;

		4)
			cp ${F_PATH} ${MY_DIRECTORY} 
			
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully copied.'
			else 
				echo 'The file was not copied'
			fi
		;;

		5)
			cat $F_PATH  
		;;

	esac }

function finding_file_by_ext () {

	cd ~
	echo 'Please introduce the file extension to find'
	EXTENSION="" 
	read EXTENSION
	declare -a EXT_OUTPUT_ARRAY=(`find -name "*${EXTENSION}*"`)
	
	#VALIDATING EXISTENCE OF FILE

	while [ "${#EXT_OUTPUT_ARRAY[@]}" -eq 0 ]; 
	do
		EXTENSION="" 
		echo 'Unable to find a files with this extension.'
		echo 'Please introduce the file extension to find'
		read EXTENSION
		declare -a EXT_OUTPUT_ARRAY=(`find -name "*${EXTENSION}*"`)
		if 	[ "${#EXT_OUTPUT_ARRAY[@]}" -ne 0 ]
		then 
			break
		fi
	done

	#PRINTING ARRAY

	for i in "${!EXT_OUTPUT_ARRAY[@]}"; 
	do 
	printf "%s\t%s\n" "$i" "${EXT_OUTPUT_ARRAY[$i]}"
	done
	echo 'Choose the file number that you want to work with'
	FILE_NUMBER="" && read FILE_NUMBER
	F_PATH=`echo ${EXT_OUTPUT_ARRAY[$FILE_NUMBER]}` 
	echo $F_PATH
	stat $F_PATH
	echo 'Which action do you want to make with the file?'
	MY_DIRECTORY=`pwd`
	echo '1:Edit | 2:Delete | 3:Move | 4:Copy to current directory | 5:Show content | 6:Exit' 
	WT_DO="" && read WT_DO
	echo $MY_DIRECTORY_EX
	#INPUT VALIDATION

		Validating_input
	
	#EXCUTING CHOSEN OPERATION 

	case $WT_DO in
		1)
			nano ${F_PATH} 
		;;

		2)   
			rm ${F_PATH} 
			RESULT=$?
			if [ $RESULT -eq 0 ] ;
			then
				echo 'The file has been successfully removed'
			else 
				echo 'The file was not removed'
			fi
		;;

		3)	
			DIRECTORY="" 
			echo 'Please introduce the Directory that you want to move the file to:' 
			read DIRECTORY
			mv ${F_PATH} ${DIRECTORY}
			RESULT=$?
			if [ $RESULT -eq 0 ] ;
			then
				echo 'The file has been successfully moved'
			else 
				echo 'The file was not moved'
			fi
			echo 'Goodbye!'
		;;

		4)
			cp ${F_PATH} ${MY_DIRECTORY}
			RESULT=$?
			if [ $RESULT -eq 0 ] ;
			then
				echo 'The file has been successfully copied.'
			else 
				echo 'The file was not copied'
			fi
			echo 'Goodbye!'

		;;

		5)
			cat $F_PATH
		;;

		6)
			echo 'Goodbye!'
			exit
		;;

	esac }

function finding_file_by_dir () {
	cd ~
	NAME=""
	DIRECTORY=""		
	echo 'Please introduce the directory where you want to search the file in.' 
	read DIRECTORY
	cd $DIRECTORY
	if [ $? != 0 ] 
	then
		VAL_DIC=` echo "Empty" `
	else 
		VAL_DIC=` echo "Not empty" `
		echo 'Valid directory'
	fi
		#VALID DATA CONFIRMATION

	while [[ "$VAL_DIC" == "Empty" ]];
		do 
				cd ~
				echo 'Directory does not exist, please try again'
				DIRECTORY=""		
				echo 'Please introduce the directory where you want to search the file in.' 
				read DIRECTORY 
				cd $DIRECTORY
				if [ $? -eq 0 ] 
				then
					VAL_DIC=` echo "Not Empty" `
				else
					VAL_DIC=` echo "Empty" `
				fi

				if [[ "$VAL_DIC" == "Not empty" ]]; 
				then
					break
				fi
		done

	echo  'Please introduce the name of the file that you want to look for in the directory.' 
	read NAME

	declare -a NAME_F_ARR=(` find -name "*${NAME}*" `)

	#VALID DATA CONFIRMATION

	while [ "${#NAME_F_ARR[@]}" -eq 0 ]; 
	do
		echo 'Unable to find a files with this name in this directory.'
		echo "     "
		echo  'Please introduce the name of the file that you want to look for in the directory.' 
		NAME="" && read NAME
		declare -a NAME_F_ARR=(`find -name "*${NAME}*"`)
		if [ "${#NAME_F_ARR[@]}" -ne 0 ]; 
		then
		exit
		fi
	done


	for i in "${!NAME_F_ARR[@]}"; 
	do 
		printf "%s\t%s\n" "$i" "${NAME_F_ARR[$i]}"
	done

	echo 'Choose the file number that you want to work with'
	FILE_NUMBER=""
	read FILE_NUMBER
	F_PATH=`echo ${NAME_F_ARR[$FILE_NUMBER]}`
	stat $F_PATH
	WT_DO=""
	MY_DIRECTORY=`pwd`
	echo 'What do you want to with the file?
		1:Edit | 2:Delete | 3:Move | 4:Copy to current directory | 5:Show content | 6:Exit ' 
	read WT_DO


	#INPUT VALIDATION
		while [[  $WT_DO -le 0 ]] || [[  $WT_DO  -ge 7 ]] || ! [[ $WT_DO =~ $NUMBER ]];
	do 
		echo 'Invalid input, please try again.'
		WT_DO="" && read WT_DO
		if  [[  $WT_DO -le 6 ]] && [[  $WT_DO  -ge 1 ]]
		then break
		fi
	done
	#EXCUTING CHOSEN OPERATION 

	case $WT_DO in
		1)
			nano $F_PATH
		
		;;
		2)   
			rm $F_PATH
			RESULT=$?
			if [ $RESULT -eq 0 ] ;
			then
				echo 'The file has been successfully removed'
			else 
				echo 'The file was not removed'
			fi
		;;
	
		3)   
			cd ~     
			MY_DIRECTORY=`pwd`     
			DIRECTORY2="" && echo 'Please introduce the Directory that you want to move the file to:' 
			read DIRECTORY2
			cd ~
			R_DIRECTORY2=` echo $(realpath "${DIRECTORY2}")`
			R_DIRECTORY=` echo $(realpath "${DIRECTORY}${F_PATH:1}")`
			mv ${R_DIRECTORY} ${R_DIRECTORY2}
		
				echo 'The file has been successfully moved'
		
		;;			
		4)
			cd ~
			MY_DIRECTORY=`pwd`
			R_DIRECTORY=` realpath "${DIRECTORY}${F_PATH:1}" `
			cp ${R_DIRECTORY} ${MY_DIRECTORY} 
			if [ $? -eq 0 ] ;
			then
				echo 'The file has been successfully copied.'
			else 
				echo 'The file was not copied'
			fi
		;;
	
		5)
			echo 'Goodbye!'
			exit
			
		;;
	
	esac }

	function input_validation () {
  while [[ "$WT_DO_P" -le 0 ]] || [[ "$WT_DO_P" -ge 5 ]] || ! [[ "$WT_DO_P" =~ $NUMBER ]];
    do 
        echo 'Invalid input, please try again.'
        WT_DO_P=""
        read WT_DO_P
        if  [[ "$WT_DO_P" -le 4 ]] && [[ "$WT_DO_P" -ge 1 ]]
            then break
        fi
    done     } 

function finding_process_by_name () {
    NAME=""
    echo 'Please insert the name of the process that you want to find' 
    read NAME
    declare -a NAME_ARR=(`pgrep ${NAME}`)
    while [ "${#NAME_ARR[@]}" -eq 0 ]; 
        do
            echo 'Unable to find active process with this name.'
            echo "     "
            echo  'Please try again.' 
            NAME="" && read NAME
            declare -a NAME_ARR=(`pgrep ${NAME}`)
            if [ "${#NAME_ARR[@]}" -ne 0 ]; 
            then
            exit
            fi
        done
    FILE_NUMBER=""
    for i in "${!NAME_ARR[@]}"; 
    do 
            printf "%s\t%s\n" "$i" "${NAME_ARR[$i]}"
    done
    echo 'Choose the process ID number that you want to work with'
    read FILE_NUMBER
    P_ID=`echo ${NAME_ARR[$FILE_NUMBER]}`
    echo $P_ID
    
    echo 'Please select the action that you want to take for the process'
    WT_DO_P=""
    
    echo '1:Show more info, 2:Stop the process ,3:Restart the process, 4:Exit' 
    read WT_DO_P
    #INPUT VALIDATION

    input_validation       

    #EXCUTING CHOSEN OPERATION 
    case $WT_DO_P in 

        1)
            top -p $P_ID
        ;;

        2)
            kill ${P_ID}
            if [ $? -eq 0 ] ;
            then 
                echo 'operation completed sucessfully'
            else 
                echo 'Invalid operation'
            fi
            echo 'Goodbye!'
        ;;

        3)
            CMD=`cat /proc/${P_ID}/cmdline |sed 's/\x0/ /g'` && kill ${P_ID} && `$CMD` &
            if [ $? -eq 0 ] ;
            then 
                echo 'operation completed sucessfully'
            else 
                echo 'Invalid operation'
            fi
            echo 'Goodbye!'
        ;;

        4)
            echo 'Goodbye!'
            exit   
            
        ;;

    esac }

function finding_process_by_id () { 


    echo 'Please insert the number ID of the process that you want to work with: '
    P_ID=""
    read P_ID
    
    echo 'Please select the action that you want to take for the process'
    echo '1:Show more info, 2:Stop the process ,3:Restart the process, 4:Exit' 
    WT_DO_P=""
    read WT_DO_P 
    #INPUT VALIDATION

        input_validation


    #EXECUTING CHOSEN OPERATION

    case $WT_DO_P in

        1)
            top -p ${P_ID}
        ;;

        
            2)
            kill ${P_ID}
                if [ $? -eq 0 ] ;
            then 
                echo 'operation completed sucessfully'
            else 
                echo 'Invalid operation'
            fi
        ;;

        3)
            CMD=`cat /proc/${P_ID}/cmdline |sed 's/\x0/ /g'` && kill ${P_ID} && `$CMD` &
                if [ $? -eq 0 ] ;
            then 
                echo 'operation completed sucessfully'
            else 
                echo 'Invalid operation'
            fi
        ;;
        
        4)
            echo 'goodbye'
            exit  
        ;;

        
    esac }
       

        #FIND PROCESS BY PORT

function finding_process_by_port () {
	PORT=""
    echo 'Please introduce the port that you want to use for the search:'
    read PORT
        declare -a PORT_ARR=(` sudo lsof -ti tcp:${PORT}`)
    #VALIDATING INPUT
    while [ "${#PORT_ARR[@]}" -eq 0 ]; 
        do
            echo 'Unable to find active process using this port'
            echo "     "
            echo  'Please try again.' 
            PORT="" && read PORT
            declare -a PORT_ARR=(` sudo lsof -ti tcp:${PORT}`)
            if [ "${#PORT_ARR[@]}" -ne 0 ]; 
            then
                break
            fi
        done
    P_ID=""
    for i in "${!PORT_ARR[@]}"; 
    do 
            printf "%s\t%s\n" "$i" "${PORT_ARR[$i]}"
    done
    FILE_NUMBER=""
    echo 'Choose the process ID number that you want to work with'
    read FILE_NUMBER
    P_ID=`echo ${PORT_ARR[$FILE_NUMBER]}`
    echo $P_ID
    WT_DO_P=""
    echo '1:Show more info, 2:Stop the process ,3:Restart the process, 4:Exit' 
    read WT_DO_P
    #INPUT VALIDATION
    input_validation

    #EXECUTING CHOSEN OPERATION

    case $WT_DO_P in

        1)
            top -p ${P_ID}
        ;;

        
        2)

            kill ${P_ID}
            RESULTS=$?
            if ["$RESULTS" -eq 0 ] ;
            then 
                echo 'operation completed sucessfully'
            else 
                echo 'Invalid operation'
            fi
            echo 'Goodbye!'
        ;;

        3)
            CMD=`cat /proc/${P_ID}/cmdline |sed 's/\x0/ /g'` && kill ${P_ID} && `$CMD` &
            echo 'operation completed sucessfully'
            echo 'Goodbye!'
            
        ;;

        4)
            echo 'goodbye'
            exit 
            
                
        ;;

    esac }



