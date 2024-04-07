<<doc 
Name: Vandana K
Date: 
Description:
Sample input:
Sample output: 
doc

#!/bin/bash

# File paths
correct_answers_file="correctanswer.txt"
user_answers_file="useranswers.txt"

# Check if files exist
if [ ! -f "$correct_answers_file" ] || [ ! -f "$user_answers_file" ]; then
    echo "Error: One or both input files do not exist."
    exit 1
fi

# Initialize total marks
total_marks=0

# Loop through each line in the files
while IFS= read -r correct_answer && IFS= read -r user_answer <&3; do
    # Check if answers match
    if [ "$correct_answer" = "$user_answer" ]; then
	# Increment marks if correct
	((total_marks++))
    fi
done <"$correct_answers_file" 3<"$user_answers_file"

				# Display total marks
				echo "Total Marks: $total_marks"


