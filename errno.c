/*
 *
 * Copyright (C) 2013 eXactLab and GC3, University of Zurich.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Moreno Baricevic <baro@exact-lab.it>
 */

#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <ctype.h>

#define MAX_KNOWN_STRERROR 132	// 132 found resolved by gnu's "%m" as of 2013-11-02

static int isint ( const register char * string , long int * result );

int main( int argc , char * const * argv )
{
    long int i = 0;

    if ( argc == 2 )
    {
        if ( isint( argv[1] , &i ) )
            errno = i , printf( "Error code %3d: %m\n" , errno ) , exit(0);
        fprintf( stderr , "*** %s: invalid non numerical argument %s\n" , argv[0] , argv[1]  );
        exit(1);
    }

    while( ( errno = i++ ) <= MAX_KNOWN_STRERROR )
        printf( "Error code %3d: %m\n" , errno );

    return 0;

} /* main */

static int isint ( const register char * string , long int * result )
{
    int i;
    char junk = '\0';

    for ( i = 0 ; i < strlen( string ) ; i++ )
        if ( ! isdigit( string[i] ) )
            return 0;

    if ( ( sscanf( string , "%ld%c" , result , &junk ) == 1 ) || junk != '\0' )
        return 1;
    else
        return 0;

} /* isint */

/***********************  E N D   O F   F I L E  ************************/
