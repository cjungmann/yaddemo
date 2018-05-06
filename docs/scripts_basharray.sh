#!/bin/bash

## This script file was used to prepare the images in the basharrays.md file.
## Running this script will create an anonymous bash console window AND
## a gedit window with this file from which the code fragments can be copied
## into the anonymous console.
##
## The create an anonymous console, it seems that you need to load a custom
## profile.  The profile is also required (as far as I can tell) to modify
## the command prompt so as to leave out the user and server names.  Another
## feature, to optimize the screen capture, is that I set the column width of
## the console to just contain the str definition as it is at this writing.
##
## I open gedit because it can set alongside the console window, and it's easier
## to copy the code fragments.

echo "PS1='\\[\\033[01;36m\\]user\\[\\033[0m\\] $ '" > /tmp/doctips_profile
xterm -fa mono -fs 9 -geometry 86x20 -e bash --rcfile /tmp/doctips_profile &
gedit scripts_basharray.sh
unlink /tmp/doctips_profile

## Exit: we don't need to run the little examples that follow.
exit


## (img1) Set the source variable
str="yad --title='YAD Dialog' --text='Behold and be amazed at this YAD Dialog'"
printf "'%s'\n" "${str}"

## (img2) expand with quotes
str="yad --title='YAD Dialog' --text='Behold and be amazed at this YAD Dialog'"
arr=( "${str}" )
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

## (img3) expand without quotes
str="yad --title='YAD Dialog' --text='Behold and be amazed at this YAD Dialog'"
arr=( ${str} )
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

## (img4) multi-line source variable, set IFS to break on newlines
str="yad
--title='YAD Dialog'
--text='Behold and be amazed at this YAD Dialog'"
IFS=$'\n' arr=( ${str} )
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

## (img5) Another multi-line source, unquoted option values
str="yad
--title=YAD Dialog
--text=Behold and be amazed at this YAD Dialog"
IFS=$'\n' arr=( ${str} )
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

## (img6) mapfile experiments using various configurations
str="yad --title='YAD Dialog' --text='Behold and be amazed at this YAD Dialog'"

echo "$str" | mapfile arr
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

echo $str | mapfile arr
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

str="yad
--title=YAD Dialog
--text=Behold and be amazed at this YAD Dialog"

echo "$str" | mapfile arr
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

echo $str | mapfile arr
echo "arr has ${#arr[@]} elements."
printf "'%s'\n" "${arr[@]}"

## (img7) Exporting an Array
arr=(yad --title "Yet-Another-Dialog" --text "Behold")
echo "arr has ${#arr[@]} elements."
export SBS_ARR="${arr[@]}"
echo "${SBS_ARR}"


## (img8) Export With Altered IFS
arr=(yad --title "Yet-Another-Dialog" --text "Behold")
OIFS=$IFS
IFS=$'\n\t '
export SBS_ARR="${arr[@]}"
echo "${SBS_ARR}"
arr=( ${SBS_ARR} )
IFS=$OIFS
printf "'%s'\n" "${arr[@]}"

## (img9) Introducing Spaces
arr=(yad --title "YAD Dialog" --text "Behold the Dialog")
OIFS=$IFS
IFS=$'\n\t '
export SBS_ARR="${arr[@]}"
echo "${SBS_ARR}"
arr=( ${SBS_ARR} )
IFS=$OIFS
printf "'%s'\n" "${arr[@]}"

## (img10) Limiting IFS to Newline
arr=(yad --title "YAD Dialog" --text "Behold the Dialog")
OIFS=$IFS
IFS=$'\n'
export SBS_ARR="${arr[@]}"
echo "${SBS_ARR}"
arr=( ${SBS_ARR} )
IFS=$OIFS
printf "'%s'\n" "${arr[@]}"

## (img11) Handling Intra-string Newlines
arr=(yad
     --title "YAD Dialog"
     --text "\
Behold the Dialog,
now using two lines."
)
OIFS=$IFS
IFS=$'\a'
export SBS_ARR="${arr[@]}"
echo "${SBS_ARR}"
arr=( ${SBS_ARR} )
IFS=$OIFS
printf "'%s'\n" "${arr[@]}"
