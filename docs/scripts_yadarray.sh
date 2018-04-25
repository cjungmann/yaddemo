#!/bin/bash

## The following YAD calls are copies of the code from yadarrays.md.  They are used
## to generate the dialogs for taking a screen print to include in the document, but
## can also be used for further experimentation.

## (ya_img1)
yad --center \
    --image=gtk-dialog-info \
    --borders=10 \
    --width=500 \
    --fixed \
    --title="Exploring Long YAD Commands" \
    --button="Done":1 \
    --text="\
This invocation of YAD is all on one command line, despite the \
fact that it shows as several lines in the script.  Escaping the \
newlines removes them to, despite appearances, form a single line."

## (ya_img2)
yad --center \
    # --image=gtk-dialog-info \
    --borders=10 \
    --width=500 \
    --fixed \
    --title="Exploring Long YAD Commands" \
    --button="Done":1 \
    --text="\
This invocation of YAD is all on one command line, despite the \
fact that it shows as several lines in the script.  Escaping the \
newlines removes them to, despite appearances, form a single line."


## (ya_img3)
cmd=(
   --center
   # --image=gtk-dialog-info
   --borders=10
   --width=500
   --fixed
   --title="Exploring Long YAD Commands"
   --button="Done":1
   --text="This invocation of YAD"
)
yad "${cmd[@]}"






