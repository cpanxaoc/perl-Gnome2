/*
 * Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS)
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2		PACKAGE = Gnome2	PREFIX = gnome_

=for object Gnome2::main

=cut

BOOT:
#include "register.xsh"
#include "boot.xsh"

void
gnome_get_version_info (class)
	SV * class
    PPCODE:
	EXTEND (SP, 3);
	PUSHs (sv_2mortal (newSViv (LIBGNOMEUI_MAJOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (LIBGNOMEUI_MINOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (LIBGNOMEUI_MICRO_VERSION)));

bool
gnome_check_version (class, major, minor, micro)
	int major
	int minor
	int micro
    CODE:
	RETVAL = LIBGNOMEUI_CHECK_VERSION (major, minor, micro);
    OUTPUT:
	RETVAL

MODULE = Gnome2		PACKAGE = Gnome2::Bonobo	PREFIX = bonobo_

void
bonobo_get_version_info (class)
	SV * class
    PPCODE:
	EXTEND (SP, 3);
	PUSHs (sv_2mortal (newSViv (LIBBONOBOUI_MAJOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (LIBBONOBOUI_MINOR_VERSION)));
	PUSHs (sv_2mortal (newSViv (LIBBONOBOUI_MICRO_VERSION)));
