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

MODULE = Gnome2::ModuleInfo	PACKAGE = Gnome2::ModuleInfo

GnomeModuleInfo *
module_info (class)
	SV * class
    ALIAS:
	Gnome2::ModuleInfo::libgnome = 1
	Gnome2::ModuleInfo::libgnomeui = 2
	Gnome2::ModuleInfo::bonobo = 3
    CODE:
	switch (ix) {
		/* casting off const to avoid compiler warnings */
		case 1: RETVAL = (GnomeModuleInfo*) LIBGNOME_MODULE; break;
		case 2: RETVAL = (GnomeModuleInfo*) LIBGNOME_MODULE; break;
		case 3: RETVAL = (GnomeModuleInfo*) gnome_bonobo_module_info_get (); break;
	}
    OUTPUT:
	RETVAL


SV *
members (module_info)
	GnomeModuleInfo * module_info
    ALIAS:
	Gnome2::ModuleInfo::name	= 1
	Gnome2::ModuleInfo::version	= 2
	Gnome2::ModuleInfo::description = 3
	Gnome2::ModuleInfo::opt_prefix	= 4
    CODE:
	switch (ix) {
		case 1: RETVAL = newSVpv (module_info->name, PL_na); break;
		case 2: RETVAL = newSVpv (module_info->version, PL_na); break;
		case 3: RETVAL = newSVpv (module_info->description, PL_na); break;
		case 4: RETVAL = newSVpv (module_info->opt_prefix, PL_na); break;
	}
    OUTPUT:
	RETVAL
