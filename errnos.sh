#!/bin/bash
#
# Copyright (C) 2013 eXactLab and GC3, University of Zurich.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Author: Moreno Baricevic <baro@exact-lab.it>
#

B='^'
E='$'
O=-w

function Usage()
{
    cat <<__EOF__>&2

Usage: $0 [ ERRFLAG | ERRNO | REGEX ]

    ERRFLAG		EPERM, ENODEV, ...
    ERRNO		1, 19, ...
    REGEX		[0-9]+, no such, ENO, ...

__EOF__
    exit 1
}
case $1 in -h|--help) Usage ;; esac

WHAT=$*
case $WHAT in
    "")	F='$3' ; WHAT='[0-9]+' ;;
    [0-9]*)	F='$3' ;;
    E*)	F='$2' ; unset E O ; b=^ ;;
    *)	F='$0' ; unset B E ; O=-i ; I='-vIGNORECASE=1' ;;
esac

find /usr/include -iname "*errno*.h"		| \
    xargs awk $I "$F~/$B$WHAT$E/{print}"	| \
    sed '/^#define[[:space:]]E/!d;s//E/;'	| \
    sort -n -k 2,2				| \
    egrep --color $O -- "$b$WHAT"		|| \
        echo >&2 "*** $0: error [$WHAT] does not exist"
