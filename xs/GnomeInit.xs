/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::Init	PACKAGE = Gnome2	PREFIX = gnome_

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

const char *
dirs (class)
	SV * class
    ALIAS:
	Gnome2::user_dir_get = 1
	Gnome2::user_private_dir_get = 2
	Gnome2::user_accels_dir_get = 3
    CODE:
	switch (ix) {
		case 1: RETVAL = gnome_user_dir_get (); break;
		case 2: RETVAL = gnome_user_private_dir_get (); break;
		case 3: RETVAL = gnome_user_accels_dir_get (); break;
	}
    OUTPUT:
	RETVAL

