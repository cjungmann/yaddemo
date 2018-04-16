# YAD (and BASH) Demo

The script files in this project preserve techniques I employ to take advantage of the
[YAD](https://sourceforge.net/projects/yad-dialog/) dialog tool.  During development,
the script files will serve as code sandboxes in which I will experiment with different
ideas.  Once I get things working, I will document how I solved certain problems and
the insight I gained.

Although YAD can be used in other environments, I am using it with BASH.  Successful
use of YAD requires use of some of the more subtle facilities of the BASH shell.  I will
document my growing understanding of BASH techniques along with YAD.

## YAD Topics

### Useful Links

- The most complete reference is accessed by typing `man yad` in a console window.
- [YAD project](https://sourceforge.net/projects/yad-dialog/)
- [The Buttons of YAD](http://www.thelinuxrain.com/articles/the-buttons-of-yad)
- [Long YAD examples page](http://smokey01.com/yad/)
- [Google Groups YAD forum](https://groups.google.com/forum/#!forum/yad-common)

### Example YAD Scripts

If this project is extracted to a directory on a Linux computer, several sample
scripts can be run to demonstrate how YAD works, and for examples for solving
certain YAD programming problems.

#### Script *main* To Start

~~~sh
~/yaddemo $ ./main
~~~

The *main* script is meant to provide convenient access to the various scripts.
It contains a form dialog that contains several buttons that serve as links to
the other scripts.  The buttons will be labelled to indicate various topics
whose contents will be below in this guide.

### YAD Programming Topics

- [YAD Button Processing](yadbuttons.md)

### YAD Button Processing

Refer also to [The Buttons of YAD](http://www.thelinuxrain.com/articles/the-buttons-of-yad).
I will be reference parts of this document to illustrate things, but, unfortunately,
the document does not include internal links.  I will direct the reader to parts of the
document with searchable strings rather than direct links.

There are two kinds of buttons in YAD, **dialog buttons** found at the bottom of a
YAD dialog, and **form buttons** that can be added to a form dialog.  They behave
differently, as described in the link above and my discussions below.

#### Dialog Buttons

Standard dialog buttons terminate the dialog with an exit value that can be examined to
determine which button was clicked.  The default buttons, *OK* and *Cancel*  set exit
values of 0 and 1, respectively.

##### Simplest Version: Default Buttons

By default, a YAD dialog will have a *Cancel* and an *OK* button at the bottom.

`$ yad --center --text="This is a YAD dialog"`

![Simple Dialog](simple1.png)

#### Custom Dialog Buttons

Including any custom button will remove the default buttons.

`$ yad --center --text="This is another YAD dialog" --button="Ok":10 --button="Exit":20`

![Custom Dialog Buttons](simple2.png)

#### Responding To Dialog Buttons

The number that follows the button label will be the exit value when the button
is pressed.

~~~sh
#!/bin/bash

while true; do
   --yad --text="This is another YAD dialog" --button="Ok":10 --button="Exit":20
   exval=$?
   case $exval in
      10) echo "You pressed OK.";;
      20|252) break;;
   esac
done
~~~

### Miscellaneous

There are some commands whose purpose or effect is unclear.  I'll add to this list as I
encounter and learn about more of them.

- *--border=NUM * NUM refers to the space between the dialog border and the dialog
  contents.  In CSS, it would be the padding.
- *--always-print-result* It appears that YAD only returns changed values.  *--always-print-result*
  forces YAD to return the entire dialog contents, even if no changes were made.

### Decorations

It is easy to add icons to your dialogs, in the main dialog or with special buttons.

You can see what GTK3 icons are available on your system with a nifty utility.  Install
the package, then run the utility:

~~~sh
sudo apt-get install gtk-3-examples
gtk3-icon-browser
~~~

If you see an icon you would like to use, open a console window and locate the icon.
For example, if you are browsing the *Emotes* category and like the *face-cool* icon,
enter the following in a console window:

~~~sh
locate face-cool
~~~

On my system, I get the following result:

~~~sh
$ locate face-cool
/usr/share/icons/Adwaita/16x16/emotes/face-cool.png
/usr/share/icons/Adwaita/22x22/emotes/face-cool.png
/usr/share/icons/Adwaita/24x24/emotes/face-cool.png
/usr/share/icons/Adwaita/256x256/emotes/face-cool.png
/usr/share/icons/Adwaita/32x32/emotes/face-cool.png
/usr/share/icons/Adwaita/48x48/emotes/face-cool.png
/usr/share/icons/Adwaita/scalable/emotes/face-cool-symbolic.svg
/usr/share/icons/HighContrast/16x16/emotes/face-cool.png
/usr/share/icons/HighContrast/22x22/emotes/face-cool.png
/usr/share/icons/HighContrast/24x24/emotes/face-cool.png
/usr/share/icons/HighContrast/256x256/emotes/face-cool.png
/usr/share/icons/HighContrast/32x32/emotes/face-cool.png
/usr/share/icons/HighContrast/48x48/emotes/face-cool.png
$
~~~

I highlight the path of the icon I want, press Ctrl-Shift-C to copy it,
then add an argument to the YAD command:

~~~sh
yad --image="/usr/share/icons/Adwaita/48x48/emotes/face-cool.png" ...
~~~








If `--button` arguments are included in the YAD call, the default dialog buttons will
be replaced with the parameter-defined buttons.

In normal usage, dialog buttons terminate the dialog and set the exit value.  The exit
value indicates the button used to terminate the dialog.

Dialog buttons can also be used to invoke a command.  

`yad --text="Demo Dialog" --button="Sit":10 --button="Stand":20 --button="Jump":30`

Dialog buttons terminate the dialog unless a command is specified


   - Dialog Buttons
     - Dialog buttons are used in functions *dialog_button_call* and *dialog_button_exit*
     - Dialog buttons terminate the dialog unless they call another function.
       - Detect the pressed button by examining the exit value `$?`.
       - The exit value will be set to the number that follows the button parameter.
         `--button="Process":2` will add a button labeled "Process" and will set the
         exit value to 2 when pressed.
       - Pay attention to default YAD exit values when assigning button values.  It is allowed
         to use the default values for custom buttons, but be aware of shadowing normal
         exit values.
       - Significant default YAD exit values
         - 0 for default OK button
         - 1 for default Cancel Button
         - 70 for timeout (if set)
         - 252 if dialog closes as the result of pressing ESC or closing the window.
   - Form Buttons
     - Form buttons do not terminate the dialog.  Active buttons must include a command.

1. Exporting internal functions to make them available to YAD processing.
   - See *funcs_export* to see how to export functions.
   - Call the exported functions with a command `bash -c function_name`
   - See *form_button_form* for an example that calls exported internal functions.
2. Button Processing


## BASH Topics

1. BASH Arrays
   - Use an array to call a command with parameters.
     - See function *form_button_call* for an example.
   - Export and retrieve arrays
     - Exported arrays are stored as a single string with a space between elements.
     - Exported arrays are reconstituted with ( ) notation, but be sure that the
       string reference within the ( )s is NOT quoted.  A quoted variable will be
       interpreted as a single value.
     - See definition of array *comargs* and exported function *response_one*
       that retrieves and uses the exported array.

2. Exported Functions
   - YAD can only access internal functions that are exported
     - See *funcs_export* to see how to export functions (using -f parameter).
     - See *form_button_call* for example using the exported functions.
     - Take care to *unset* the function names so they can't be accessed
       when the script ends.
   - Exported functions cannot access the script's global variables.
     - Any necessary global variables must be exported to be visible to exported functions.
     - See *funcs_export* to see both exported functions AND an array.
     - See *response_one* to see how to reconstitute an exported array.
