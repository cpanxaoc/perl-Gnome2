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

MODULE = Gnome2::Util	PACKAGE = Gnome2::Util	PREFIX = gnome_util_

const char *
g_extension_pointer (class, path)
	SV *class
	const char *path
    ALIAS:
	extension = 1
    C_ARGS:
	path

void
gnome_util_prepend_user_home (class, file)
	SV *class
	gchar *file
    PREINIT:
	gchar *result;
    PPCODE:
	result = gnome_util_prepend_user_home (file);
	EXTEND (sp, 1);
	PUSHs (sv_2mortal (newSVGChar (result)));
	g_free (result);

void
gnome_util_home_file (class, file)
	SV *class
	gchar *file
    PREINIT:
	gchar *result;
    PPCODE:
	result = gnome_util_home_file (file);
	EXTEND (sp, 1);
	PUSHs (sv_2mortal (newSVGChar (result)));
	g_free (result);

void
gnome_util_user_shell (class)
	SV *class
    PREINIT:
	char *result;
    PPCODE:
	result = gnome_util_user_shell ();
	EXTEND (sp, 1);
	PUSHs (sv_2mortal (newSVpv (result, PL_na)));
	g_free (result);
