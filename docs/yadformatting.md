# YAD Dialog Formatting

There is nothing in this guide that cannot be easily discovered with some experimentation,
but showing some examples will save some time.

## Centering the Dialog

It is easier for the user to find the dialog if it's always in the same place.  Using the
`--center` option directs YAD to create the new dialog in the center of the window.

- *main* -> *YAD Dialog Formatting* -> *YAD Centered*

## Dialog Width

The width of a dialog is, initially, determined by the width of certain elements of the
dialog. YAD will stretch the dialog to contain the dialog buttons and the dialog text
(set with the `--text` option).  There is also an option, `--width` that can be used to
set a minimum width in case the buttons or the text are missing or too short to result
in a pleasing format.

One option that **does not** affect the dialog width is the `--title` option, which sets
the caption bar text.  Instead, the title will be truncated to fit if the dialog is not
wide enough to contain the title.

At least two things (I may be missing others) determine the width of a dialog, the
`--width` option and the `--text` option.  The `--width` option is works as expected, but the
`--text` was a surprise, coming from HTML development.

The dialog will expand horizontally to contain the contents of the `--text` option.
If the text is set to a very long string without any newlines, the dialog will be rendered
wide enough to contain the text.

The `--width` option overrides the text width, so a single long line of text will be broken
to fit within the width request.

Find the examples of a long text option, with and without incorporated newlines, at
- *main* -> *YAD Dialog Formatting* -> *YAD Too Long*, and
- *main* -> *YAD Dialog Formatting* -> *YAD Width-restrained Too Long*, and
- *main* -> *YAD Dialog Formatting* -> *YAD Just Right*.

## Dialog Height

For some reason, when the `--text` option string is very long, the YAD dialog gets very tall,
many times taller than necessary to contain the text.  Even setting the `--height` fails to
overcome this unfortunate formatting problem.

Setting the `--fixed` option seems to help with this.  With a long `--text` string, setting
`--fixed` will honor the `--height` option, or simple size the dialog to fit the long text.


## YAD Borders

I had expected the `--borders` option to create a thick border around the dialog, but, instead,
the `--borders` option creates space between the dialog's border and its contents.  It behaves
like the CSS *padding* property.

Find an example of the formatted text dialog with borders to make a nicer dialog:

- *main* -> *YAD Dialog Formatting* -> *YAD Just Right and Loosened*
