# YAD Utilities

I have included several BASH scripts that provide different services.

## utilties

This script is the landing place for a jump from `main`.  It includes buttons to the
utilties listed below.  

## icon-browser

The YAD man page mentions a `yad-icon-browser` utility that *allegedly* allows one to
browse through a set of icons.  I couldn't find it on my computer, so I decided that it
might be interesting to create my own icon browser.

In addition to being a somewhat useful utility for seeing names and images of your
computers inventory of stock GTK images, it demonstrates a few YAD and BASH techniques:

- The script uses Linux utilities `locate` and `grep` find the GTK stock image names.
- It creates a YAD list element with an image and a text column, then populates the list
  with images and their stock GTK name.
- The invocation of **yad** escapes newlines between options and includes newlines
  in the text option.

## mysql-browser

This utility includes a few features that are accessed from the `utilities` script or from
the command line when `mysql-browser` is called with an argument.  This is likely to change,
with this document being updated once it's in a final form.

- The script includes function `stringify_array` that processes an array to create a string
  from which the array can be reconstituted.
- Uses `--xml` mode on mysql, processing the resultant document using the stylesheet *sql2yad.xsl*
  with `xsltproc`  to create the list columns and the data rows.
- It is disappointing that I can't get fields meta data in XML mode.  My BASH kung fu is not
  sufficient to parse the meta data from the text output.  Thus, the column types are all text.

There are two modes in which to run mysql-browser, *query* and *drill*.

- **drill** opens to show the database in the MySQL server.  Clicking on a database will open
  a new dialog listing the tables in that database.  Clicking on a table will show the fields'
  meta data.

- **query** accepts a query, processing it and returning the data as a list view.
