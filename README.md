# PerlMagick-Hint

A helper script to compile `PerlMagick`, the Perl binding of
[ImageMagick](https://imagemagick.org/).

- [PerlMagick-Hint](#perlmagick-hint)
	- [Description](#description)
	- [BUGS](#bugs)
	- [COPYRIGHT](#copyright)

## Description

This is the accompanying repository to the blog post
https://www.guido-flohr.net/compile-perlmagick/.  See there for more
information.

**tl;dr**:

1. Download and unpack ImageMagick from https://metacpan.org/dist/Image-Magick.
2. Create a directory hints inside the directory created.
3. Copy `hint.pl` into the directory `hints`.
4. Run the script with `perl hints/hint.pl`.  It will tell you how you have to rename it in order to be recognized.
5. Build and install with the usual `perl Makefile.PL && make && make install`.

## BUGS

Please report bugs at https://github.com/gflohr/perlmagick-hint/issues!

## COPYRIGHT

This is free software.  Copyright © 2024 Guido Flohr
<https://www.guido-flohr.net>, released under the terms and conditions
of the [WTFPL 2 license](https://wtfpl2.com/).
