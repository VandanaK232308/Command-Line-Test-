<<doc 
Name: Vandana K
Date: 
Description:
Sample input:
Sample output: 
doc

#!/bin/bash
echo "1. Signup."
echo "2. Signin."
echo "3. exit."
read -p "Enter the choice: " choice
case $choice in
    1) read -p "Enter the username: " uname
	read -sp "Enter the password: " password
	echo ""
	read -sp "Confirm your password: " confirm
	echo ""
	if [ $password -eq $confirm ]
	then
	    echo "Successfully logged In."
	    echo "$uname" >> username.csv
	    echo "$password" >> password.csv
	else
	    echo "Password and Confirm password should be same."
	fi
	;;
    2) read -p "Enter the username: " uname
	read -sp "Enter the password: " password
	echo ""
	if grep -qxlw "^$uname$" username.csv && grep -qxlw "^$password$" password.csv; then
	    echo "Signned In Successfully."
	    echo "1. Take test."
	    echo "2. exit."
	    read -p "Enter the choice: " test
	    case $test in
		1)echo""
		    echo -e "\e[92mWELCOME $uname\e[0m"
		    echo -e "\e[92mALL THE BEST!\e[0m"
		    echo""
		    for i in $(seq 5 5 50)
		    do
			head -n $i questions.txt | tail -n -5
			for j in `seq 10 -1 1`
			do
			    echo -ne "\rEnter the option: $j "
			    read -t 1 option
			    if [ ${#option} -gt 0 ];
			    then
				break
			    else
				option="e"
			    fi
			done
			echo option = $option

			echo "$option" >> useranswers.txt
		    done


		    for i in $(seq 5 5 50); do
			echo "Question $((i / 5)):"
			head -n $i questions.txt | tail -n 5

			j=$((i / 5))
			correct_answer=$(sed -n "${j}p" "correctanswer.txt")
			user_answer=$(sed -n "${j}p" "useranswers.txt")

		#	if [ "$user_answer" = e ];
		#	then
		#	    echo -e "\e[91mTime Out!\e[0m"
		#	fi

		if [ "$correct_answer" = "$user_answer" ]; then
		    echo -e "\e[92mCorrect Answer\e[0m"
		    #echo "Correct Answer"
		    if [ "$user_answer" == e ];
		    then
			echo -e "\e[91mTime Out!\e[0m"
		    fi
		    else
			echo -e "\e[91mWrong Answer\e[0m"
		    fi
		
		echo "Your answer : $user_answer"
		echo "Correct answer : $correct_answer"
		echo ""
	    done

	    correct_answers_file="correctanswer.txt"
	    user_answers_file="useranswers.txt"

	    if [ ! -f "$correct_answers_file" ] || [ ! -f "$user_answers_file" ]; then
		echo "Error: One or both input files do not exist."
		exit 1
	    fi

	    total_marks=0

	    while IFS= read -r correct_answer && IFS= read -r user_answer <&3; do
		if [ "$correct_answer" = "$user_answer" ]; then
		    ((total_marks++))
		fi
	    done <"$correct_answers_file" 3<"$user_answers_file"
	    echo  -e "\e[92mTotal Marks: $total_marks / 10"
	    echo""
	    echo -e "\e[92mTHANKYOU $uname"
	    echo""

	    if [ -f "useranswers.txt" ]; then
		> "useranswers.txt"
	    fi
	    ;;
	2) exit 0
	    ;;
	*)"Default case."
	    ;;
    esac
else
    echo "Invalid username or password."
	fi
	;;
    3) exit 0
	;;
    *) "Default case"
	;;
esac

