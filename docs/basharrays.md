# BASH Arrays

## Creating BASH Arrays

There are several ways to create BASH arrays.  Arrays can be created with the simple `( ... )`
syntax, with the `declare` command, and with the `mapfile` (alias `readarray`) commands.
(The `man` information about these commands will be found in the BASH man page.  Use the
**/** search tool to find the topics.)

The examples in [YAD Arrays](yadarrays.md) used the simple `( ... )` notation.  The following
short example will create an array named *cmd* with three elements:

## Experimenting with BASH Variables

To inexperienced programmers, BASH variable handling can seem very particular.  Look at the
following screen print to see how different syntax results in different outcomes.  The examples
will use `printf "'%s'\n"` to show the results of each string substitution.  Using `printf` this
way will separate the elements makes it easier to see what an array element begins and ends.

### Reproducing the Document Images

This repository includes the file `docs/array_scripts.sh` that was used to create the images
found below.  Run the script to create an anonymous console window (ie without user or computer
names) and a `gedit` window with the array_scripts.sh file.   Copy code fragments from the `gedit`
window to the console to run them (copy from gedit with Control-C, then paste into the console
with Shift-Insert).  Type Alt-PrScr to copy a snapshot of the console window to your copy
buffer.

### Experiments Converting a String to an Array

This set of experiments will create a string with three elements.  Different handling of the
string will result in differnt outcomes, as will be illustrated below.

Each experiment will show the count of array elements with `echo "arr has ${#arr[@]} elements"`.
Then it will show the elements themselves  with `printf "'%s'\n" "${arr[@]}"` so that
the apostrophes clearly mark the beginning and end of an array element which may include
newlines that would otherwise be ambiguous.

#### Create and View the String

This first image mainly establishes the contents of the array string.  It includes three
items to create a YAD dialog.  The following experiments will change the construction of
the string and the array.

![elements in a string](img1.png)

#### Create Array from String, Quoted Substitution
In this experiment, we begin to use the *array initialization* parentheses with a quoted
variable invocation.  It does not work as we want:

![quoted substitution yields too few array elements](img2.png)

You can see that the array only has a single element, not the three we were hoping for.
Enclosing the variable name with quotes, `arr=( "${str}" )`, forces BASH to treat the
entire string as a single value, thus a single array element.

#### Create Array from String, Unquoted Substitution

In this experiment, we properly leave off the quotes, and BASH dutifully breaks the
string into discrete elements:

![unquoted substitution yields too many array elements](img3.png)

Using the unquoted substitution, `arr=( ${str} )` results in too many array elements.
The problem is that BASH is breaking the string on white-space characters, specifically
any space, tab, or newline is taken to signal the beginning of a new element.  Even though
the text strings are enclosed in single-quotes, the enclosed spaces trigger new elements.

#### Setting IFS Value for Better Breaks

Allowing BASH to break the string by spaces, tabs, or newlines is too permissive because
it causes too many breaks.  This experiment introduces newlines into the array source
string, then breaks the array *only* on the newlines:

![unquoted substitution with newlines and IFS](img4.png)
This is the desired result, an array with three elements.

The **IFS** environment variable dictates how a string is converted to an array.  Any character
in the *IFS* variable will be taken as an element boundary.  The default value of *IFS* of
 `$' \t\n'` means that a space, tab, or newline will begin a new array element.  Also note that
consecutive white space characters will be treated as a single break.

In this example, we have replaced the default *IFS* value with the single newline character,
`IFS=$'\n'` so neither tabs nor spaces will not cause element breaks.  An
important feature of this example is that, by setting *IFS* value on the same line as the
array substitution, the IFS value reverts to the its previous setting when the statement
is finished.

#### Omitting Value String Quotes
Having removed spaces from the list of field separators, we no longer need to use quotes
to keep the sentences together:

![with newlines field separators, quotes are not needed for string values](img5.png)

This may not be array nirvana, however, depending on how the array elements are used.
The above array works for YAD, but may not work if the target command needs to further break
down the elements because the `--title=YAD Dialog` might be broken into two items,
`title=YAD` and `Dialog`.  In that case, you may have to continue quoting the string.

### Alternate Array Initializations

Besides the `( )` array initialization, BASH has built-in commands that can also create
arrays when the parentheses fall short.  Find these commands in `man bash`, slash-search
for `^SHELL BUILTIN COMMAND`, then from there search for the command.

#### Using *mapfile*

The commands **mapfile** and **readarray** are actually aliases for the same function that
builds an array from a string or a file.  The main advantage the **mapfile** offers is the
options available to tweak construction.  As shown below, **mapfile** is also more forgiving
with the input data, returning the same array whether the string is multi-line or single-line,
and whether the variable is quoted or not.

![mapfile examples](img6.png)

Find documentation for *mapfile* and *readarray* in `man bash`.

