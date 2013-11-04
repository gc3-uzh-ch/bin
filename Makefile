#!/bin/make -f
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


errno: errno.c
	gcc -Wall $^ -o $@
	strip $@

clean:
	@rm -vf errnos

check: errnos errnos.sh
	./errnos.sh 19
	./errnos.sh ENODEV
	./errnos.sh no such device
	./errnos.sh no such | wc -l
	./errnos.sh | wc -l
	./errnos 19
	./errnos | wc -l
	./errnos.sh 515
	./errnos 515
