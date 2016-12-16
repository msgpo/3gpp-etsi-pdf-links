#!/bin/sh

# a rather simple script to recursively dowload all of the ETSI technical
# specifications in PDF format

wget -c -r -np http://www.etsi.org/deliver/etsi_ts/
