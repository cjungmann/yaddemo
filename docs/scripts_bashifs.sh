#!/bin/bash

open_mini_bash()
{
    echo "PS1='\\[\\033[01;36m\\]user\\[\\033[0m\\] $ '" > /tmp/doctips_profile
    xterm_args=(
        -fa mono
        -fs 9
        -geometry 65x20
        -e
        bash
        --rcfile /tmp/doctips_profile
        ./scripts_bashifs.sh
        )

    xterm "${xterm_args[@]}" &

    gedit scripts_bashifs.sh
    unlink /tmp/doctips_profile
}


if [ $# -gt 0 -a $1 == "sprint" ]; then
    open_mini_bash
    exit 0
fi

echo
echo "Simple BASH Array Creation for image 1"
## (bashifs1.png)
arr=( one two three four five )
echo "${#arr[@]} elements: ${arr[@]}"

arrstr="un deux  trois   quatre    
   cinq"
arr=( $( echo "$arrstr" ) )
echo "${#arr[@]} elements: ${arr[@]}"

echo
echo "IFS for CSV BASH Array Creation in image 2"
## (bashifs2.png) CSV
arrstr="one,two,three,four"
IFS=$','
arr=( $( echo "$arrstr" ) )
echo "${#arr[@]} elements: ${arr[@]}"

echo
echo "IFS Multi-Character Trap in image 3"
## (bashifs3.png)  Multi-char IFS Trap
# Split as expected:
arrstr="one, two, three, four"
IFS=$', '
arr=( $( echo "$arrstr" ) )
echo "${#arr[@]} elements: ${arr[@]}"

# Suprise split:
arrstr="little one, medium two, big three, huge four"
arr=( $( echo "$arrstr" ) )
echo "${#arr[@]} elements: ${arr[@]}"

echo
echo "AWK Alternative for Substring Split in image 4"
## (bashifs4.png) Use AWK to split string
arrstr="little one, medium two, big three, huge four"
IFS='^'
arr=( $( awk 'BEGIN {RS=", "; ORS="^"} { print $0 }' <<< "$arrstr" ) )
echo "${#arr[@]} elements:"
printf "'%s'\n\n" "${arr[@]}"


echo
echo "IFS to Capture Multiline Elements in image 5"
## (bashifs5.png) Elements with embedded spaces
arrstr="clean
room	wash
dishes	feed
dog	weed
garden"
arr=( $( echo "$arrstr" ) )
echo "${#arr[@]} elements: ${arr[@]}"
IFS=$'\t'
arr=( $( echo "$arrstr" ) )
echo "${#arr[@]} elements:"
printf "'%s'\n" "${arr[@]}"


echo
echo "Array Brace Expansion to Function in code listing"
## bashifs6.png) Screen shot of results of these functions called by
## function multid_demo below
seek_index()
{
   local el target="$1"
   local -i ndx=0

   for el in "${@:2}"; do
      if [ "$el" == "$target" ]; then
         echo "${ndx}"
         return 0
      fi
      (( ndx++ ))
   done

   return 1
}

# Use the index-seeking function with an array expansion:
declare result
declare -a arr=(one two three four five)
declare -i exval

# Restore IFS to default setting:
IFS=$' \t\n'

echo
echo "Using seek_index function with [@] indexing:"
result=$( seek_index "one" "${arr[@]}" )
exval=$?
if [ $exval -eq 0 ]; then
   echo "'one' is at index $result in the array."
else
   echo "'one' was not found in the array ($exval)."
fi

echo
echo "Using seek_index function with [*] indexing:"
echo "(Expected same result as [@] by using IFS=\$' ', but"
echo " surprised to see \${arr[*]} resolves to single value.)"
IFS=$' '
result=$( seek_index "one" "${arr[*]}" )
exval=$?
if [ $exval -eq 0 ]; then
   echo "'one' is at index $result in the array."
else
   echo "'one' was not found in the array ($exval)."
fi



echo
echo "IFS, Brace Expansion and Multi-dimensional Arrays"
# This function takes advantage of direct access to
# variables in the calling function's scope.
assign_student_grades()
{
   local stuid
   local -a rec
   local -i grade ndxGrade
   local IFS

   ndxGrade=$( seek_index "grade" "${fields[@]}" )
   if [ $? -ne 0 ]; then
       echo "seek_index failed to find 'grade' field." >&2
       exit 1
   fi

   for stuid in "${!students[@]}"; do
      # Unpack student record into an array:
      IFS="^"
      rec=( $( echo "${students[$stuid]}" ) )

      # Randomly assign a letter grade:
      grade=$(( $RANDOM % 4 ))
      rec[$ndxGrade]="${grade_letters[$grade]}"

      # Update the main array with changed record:
      students[$stuid]="${rec[*]}"
   done
}

show_students()
{
   local stuid
   local -a rec
   local IFS

   # Reusable format string for column consistency:
   local fmat="%10s %10s %12s %10s\n"

   # Table header
   printf "${fmat}" "${fields[@]}"

   for stuid in "${!students[@]}"; do
      # Unpack student record into an array:
      IFS="^"
      rec=( $( echo "${students[$stuid]}" ) )
      printf "${fmat}" "${rec[@]}"
   done
}



multid_demo()
{
    declare -a fields=( lname fname bday grade )
    declare -A students=(
        [1234]="Smith^Joe^2002/08/21^^"
        [1235]="Jones^Chuck^2003/01/19^^"
        [1236]="Doe^Jane^2002/09/08^^"
        [1237]="Rogers^Anne^2002/11/17^^"
    )

    echo "These are the sample students."
    show_students

    echo
    echo "Going off to randomly assign grades."
    assign_student_grades

    echo
    echo "Display student records again to show the grades."
    show_students
}

multid_demo


read

