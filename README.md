# YAD (and BASH) Demo

I have recently begun to explore the possibilities of the
[YAD (**y**et **a**nother **d**ialog)](https://sourceforge.net/projects/yad-dialog/)
dialog tool.  It seems to be the best tool (relatively easy to learn and use) for
creating a user interface for a Linux script.  This project will be a place for me
to save working BASH scripts that use YAD and to document how I solve problems.

Although YAD can be used in other environments, I am using it with BASH.  Successful
use of YAD requires use of some of the more subtle facilities of the BASH shell.  I will
document my growing understanding of BASH techniques along with YAD.

## YAD Scripts

This repository contains both BASH scripts and Markdown documents.  The scripts can be
run directly, or accessed through the `main` script.  To make it easier to find the
examples, the `main` script shows buttons labelled after the topics below.

Run the main script from a console window:

~~~sh
me:~/yaddemo$ ./main
~~~

## YAD Topics

### YAD Button Processing

[YAD Button Processing](docs/yadbuttons.md)

A GUI button is a widely-recognized metaphor for a physical push button as a tool
to initiate an action.  YAD includes options for creating and manipulating buttons
on the dialog and as parts of forms.

### YAD Formatting

[YAD Formatting](docs/yadformatting.md)

YAD provides several options for changing the appearance of the dialogs.  This topic
will cover a growing subset of these options as I find uses for them.

### YAD Utilities

[YAD Utilities](docs/yadutilities.md)

I have included a few BASH utilties that use YAD as the user interface.  They might
be useful as examples for using YAD in a larger context.

Unlike other YAD-using BASH scripts, the utility scripts reside in a `utilities`
directory.

### YAD Arrays

[YAD Arrays](docs/yadarrays.md)

I often invoke YAD with the options in an indexed array.   It's nicer to look at an
array than an extended line with escaped newlines.  I also use an array to collect
common YAD options to facilitate a constant look among the YAD dialogs in an 
application.

### BASH Arrays

[BASH Arrays](docs/basharrays.md)

If you embrace the recommendations in the [YAD Arrays](docs/yadarrays.md) page, you may
benefit from a further discussion on the use of arrays in BASH.  People familiar with
other programming languages will be suprised by the syntax and mechanics of BASH arrays
and variable expansions.

Besides having an introduction to the syntax differences with using BASH variables, this
page will talk about the why BASH cannot save arrays in an environment variable and will
present one successful method for saving and restoring BASH arrays variables.

### Returning BASH Arrays

[Returning BASH Arrays](docs/bashreturnarray.md)

BASH has reasonable, if unconventional, features for handling arrays.  Unfortunately,
BASH lacks features for easily passing arrays to and from other functions.  Because it
is sometimes useful to delegate the construction of an array to another function, I have
worked out a few strategies for simulating a function returning an array.

### BASH Arrays with IFS

[BASH Arrays with IFS](doc/bashifs.md)

The **IFS** environment variable is a powerful tool for manipulating arrays.  This
guide presents some examples of how to take advantage of IFS.  The guide includes
an example of using *IFS* to create multi-dimensional BASH arrays

### BASH Scoping

[BASH Scoping](docs/bashscope.md)

I was making some bad assumptions about how BASH variables are scoped.  This page talks
about how BASH variables, created in one function, are visible to functions called by
by the function in which the variables are created.

This page also covers a BASH trap I fell into, having made a bad assumption about
how an exit status value was set.

### BASH Conditionals

[BASH Conditionals(docs/bashconditionals.md)

BASH variables cannot hold a boolean value.  What does that mean?  Look at an
alternative construction using a nested function.

### External YAD Resources

As I began exploring the limits of YAD, I found the following documentation useful as
a source of examples and explanations.

- The YAD man page (`man yad`) is the most complete reference.  This quickly became
  my most used reference as I exhausted limited range of examples in the other
  sources.
- [YAD Project Page](https://sourceforge.net/projects/yad-dialog/)
- [The Buttons of YAD](http://www.thelinuxrain.com/articles/the-buttons-of-yad)
- [Long YAD examples page](http://smokey01.com/yad/)
- [Google Groups YAD forum](https://groups.google.com/forum/#!forum/yad-common)

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
