#!/bin/sh

# a rather simple script to recover the 3GPP spec number (if any) from the
# title page of the ETSI TS PDF and then create a symlink in the format
# $SPEC-$VERSIO.pdf

# Author: Harald Welte <laforge@gnumonks.org>

# source base directory containing the ETSI TS PDFs
SRCDIR=./www.etsi.org/deliver/etsi_ts

# directory from where to create all the symlinks
LINKDIR=./by_chapter

# ensure the symlink directory exists
[ -d $LINKDIR ] || mkdir $LINKDIR

# get a list of all pdf files
PDFS=`find $SRCDIR -name "*.pdf"`

for f in $PDFS; do
	# check if it contains a line with suitable prefix
	RES=`pdfgrep -m 1 '\(3GPP TS' $f`
	if [ $? -eq 0 ]; then
		# extract the filename with spec number + version name (e.g. 44.008-4.0.0.pdf)
		LINK=`echo $RES | awk '/\(3GPP TS ([0-9]+\.[0-9]+) version (\w+)/ {printf "%s-%s.pdf", $3, $5}'`
		if [ "x$LINK" != "x" ]; then
			echo $LINK
			# crate the actual symlink
			ln -sf ../$f "$LINKDIR/$LINK"
		fi
	fi
done

