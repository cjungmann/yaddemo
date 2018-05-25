# YAD Composite Dialogs

YAD includes two types of composite dialogs, **notebook** and
**paned**.  The two versions work similarly, in that the constituent
sub-dialogs are started in the background with an integer **plug**
value, then the container dialog is started with a **key** option set
to the shared **plug** value.

## Composite Dialog Challenges

There are several unique considerations when making composite dialogs.
From setup to handling results, composite dialogs require many more
steps than standalone dialogs.


## Where to Find the Experiments

This guide is unusual in that code, dialog images, and data results
will not be incorporated into the page.  To discuss a topic, one needs
to look at lengthy code, view the resulting dialog, and consider the
result in the console window.  It is recommended that the code be
studied with two console windows, both open in the directory of the
companion script file, **yadcomposite**.  One window should be running
a text editor with the *yadcomposite* file open, and the second window
being used to run the various experiments while looking at the code.

### Data Assignment Challenge

Demo script: `yadcomposite oop`

It can be challenging to populate a YAD dialog with data.  A text
parameter is applied to the first empty dialog element that preceeds
it.  The more empty dialog elements there are, the more chances there
are that the data can get out of sync.  A composite dialog, having
two or more sub-dialogs with their own set of empty slots, increases
the opportunity for an error.

In this case, the script experiment does not use a composite dialog
because the effect is more easily observed with a simpler dialog.

### Using a Paned Dialog

Demo script: `yadcomposite paned`



### Notebook Dialog Demo

Demo script `yadcomposite notebook`

### Paned List Problems

Demo script `yadcomposite plp`





  The data
must be sent to the dialog in the same order and number as the empty
fields in the dialog.  Having to organize the fields data for
multiple pages in one submission.

If loading data is complicated, getting it back with the user's
responses is more so.  The order in which the pages are returned is
undefined.

This page will show you some examples and hints for setting up
composite dialogs, and a method for determining the order of the
returned data.


