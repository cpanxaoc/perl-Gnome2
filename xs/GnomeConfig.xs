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

/*

gnome_config_get_vector
gnome_config_private_get_vector
gnome_config_get_vector_with_default
gnome_config_private_get_vector_with_default

*/

MODULE = Gnome2::Config	PACKAGE = Gnome2::Config	PREFIX = gnome_config_

char *
get_string (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_string = 0
	Gnome2::Config::get_translated_string = 1
	Gnome2::Config::Private::get_string = 2
	Gnome2::Config::Private::get_translated_string = 3
    CODE:
	switch (ix) {
		case 0: RETVAL = gnome_config_get_string (path); break;
		case 1: RETVAL = gnome_config_get_translated_string (path); break;
		case 2: RETVAL = gnome_config_private_get_string (path); break;
		case 3: RETVAL = gnome_config_private_get_translated_string (path); break;
	}
    OUTPUT:
	RETVAL
    CLEANUP:
	g_free (RETVAL);

void
get_string_with_default (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_string_with_default = 0
	Gnome2::Config::get_translated_string_with_default = 1
	Gnome2::Config::Private::get_string_with_default = 2
	Gnome2::Config::Private::get_translated_string_with_default = 3
    PREINIT:
	char *retval;
	gboolean def;
    PPCODE:
	switch (ix) {
		case 0: retval = gnome_config_get_string_with_default (path, &def); break;
		case 1: retval = gnome_config_get_translated_string_with_default (path, &def); break;
		case 2: retval = gnome_config_private_get_string_with_default (path, &def); break;
		case 3: retval = gnome_config_private_get_translated_string_with_default (path, &def); break;
	}

	EXTEND (sp, 1);
	PUSHs (sv_2mortal (newSVuv (def)));
	if (retval != NULL)
		XPUSHs (sv_2mortal (newSVpv (retval, PL_na)));

	g_free (retval);

int
get_int (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_int = 0
	Gnome2::Config::Private::get_int = 1
    CODE:
	switch (ix) {
		case 0: RETVAL = gnome_config_get_int (path); break;
		case 1: RETVAL = gnome_config_private_get_int (path); break;
	}
    OUTPUT:
	RETVAL

void
get_int_with_default (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_int_with_default = 0
	Gnome2::Config::Private::get_int_with_default = 1
    PREINIT:
	int retval;
	gboolean def;
    PPCODE:
	switch (ix) {
		case 0: retval = gnome_config_get_int_with_default (path, &def); break;
		case 1: retval = gnome_config_private_get_int_with_default (path, &def); break;
	}

	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVuv (def)));
	PUSHs (sv_2mortal (newSViv (retval)));

gdouble
get_float (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_float = 0
	Gnome2::Config::Private::get_float = 1
    CODE:
	switch (ix) {
		case 0: RETVAL = gnome_config_get_float (path); break;
		case 1: RETVAL = gnome_config_private_get_float (path); break;
	}
    OUTPUT:
	RETVAL

# FIXME: seems to return integers instead of floats.
void
get_float_with_default (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_float_with_default = 0
	Gnome2::Config::Private::get_float_with_default = 1
    PREINIT:
	gdouble retval;
	gboolean def;
    PPCODE:
	switch (ix) {
		case 0: retval = gnome_config_get_float_with_default (path, &def); break;
		case 1: retval = gnome_config_private_get_float_with_default (path, &def); break;
	}

	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVuv (def)));
	PUSHs (sv_2mortal (newSVnv (retval)));

gboolean
get_bool (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_bool = 0
	Gnome2::Config::Private::get_bool = 1
    CODE:
	switch (ix) {
		case 0: RETVAL = gnome_config_get_bool (path); break;
		case 1: RETVAL = gnome_config_private_get_bool (path); break;
	}
    OUTPUT:
	RETVAL

void
get_bool_with_default (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::get_bool_with_default = 0
	Gnome2::Config::Private::get_bool_with_default = 1
    PREINIT:
	gboolean retval;
	gboolean def;
    PPCODE:
	switch (ix) {
		case 0: retval = gnome_config_get_bool_with_default (path, &def); break;
		case 1: retval = gnome_config_private_get_bool_with_default (path, &def); break;
	}

	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVuv (def)));
	PUSHs (sv_2mortal (newSVuv (retval)));

# --------------------------------------------------------------------------- #

void
set_string (class, path, value)
	const char *path
	const char *value
    ALIAS:
	Gnome2::Config::set_string = 0
	Gnome2::Config::set_translated_string = 1
	Gnome2::Config::Private::set_string = 2
	Gnome2::Config::Private::set_translated_string = 3
    CODE:
	switch (ix) {
		case 0: gnome_config_set_string (path, value); break;
		case 1: gnome_config_set_translated_string (path, value); break;
		case 2: gnome_config_private_set_string (path, value); break;
		case 3: gnome_config_private_set_translated_string (path, value); break;
	}

void
set_int (class, path, value)
	const char *path
	int value
    ALIAS:
	Gnome2::Config::set_int = 0
	Gnome2::Config::Private::set_int = 1
    CODE:
	switch (ix) {
		case 0: gnome_config_set_int (path, value); break;
		case 1: gnome_config_private_set_int (path, value); break;
	}

void
set_float (class, path, value)
	const char *path
	gdouble value
    ALIAS:
	Gnome2::Config::set_float = 0
	Gnome2::Config::Private::set_float = 1
    CODE:
	switch (ix) {
		case 0: gnome_config_set_float (path, value); break;
		case 1: gnome_config_private_set_float (path, value); break;
	}

void
set_bool (class, path, value)
	const char *path
	gboolean value
    ALIAS:
	Gnome2::Config::set_bool = 0
	Gnome2::Config::Private::set_bool = 1
    CODE:
	switch (ix) {
		case 0: gnome_config_set_bool (path, value); break;
		case 1: gnome_config_private_set_bool (path, value); break;
	}

# --------------------------------------------------------------------------- #

gboolean
bools (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::has_section = 0
	Gnome2::Config::Private::has_section = 1
	Gnome2::Config::sync_file = 2
	Gnome2::Config::Private::sync_file = 3
    CODE:
	switch (ix) {
		case 0: RETVAL = gnome_config_has_section (path); break;
		case 1: RETVAL = gnome_config_private_has_section (path); break;
		case 2: RETVAL = gnome_config_sync_file ((char *) path); break;
		case 3: RETVAL = gnome_config_private_sync_file ((char *) path); break;
	}
    OUTPUT:
	RETVAL

void
voids (class, path)
	const char *path
    ALIAS:
	Gnome2::Config::drop_file = 0
	Gnome2::Config::Private::drop_file = 1
	Gnome2::Config::clean_file = 2
	Gnome2::Config::Private::clean_file = 3
	Gnome2::Config::clean_section = 4
	Gnome2::Config::Private::clean_section = 5
	Gnome2::Config::clean_key = 6
	Gnome2::Config::Private::clean_key = 7
    CODE:
	switch (ix) {
		case 0: gnome_config_drop_file (path); break;
		case 1: gnome_config_private_drop_file (path); break;
		case 2: gnome_config_clean_file (path); break;
		case 3: gnome_config_private_clean_file (path); break;
		case 4: gnome_config_clean_section (path); break;
		case 5: gnome_config_private_clean_section (path); break;
		case 6: gnome_config_clean_key (path); break;
		case 7: gnome_config_private_clean_key (path); break;
	}

gchar *
get_real_path (class, path=NULL)
	gchar *path
    ALIAS:
	Gnome2::Config::get_real_path = 0
	Gnome2::Config::Private::get_real_path = 1
    CODE:
	switch (ix) {
		case 0: RETVAL = gnome_config_get_real_path (path); break;
		case 1: RETVAL = gnome_config_private_get_real_path (path); break;
	}
    OUTPUT:
	RETVAL
    CLEANUP:
	g_free (RETVAL);

##  void gnome_config_drop_all (void) 
void
gnome_config_drop_all (class)
    C_ARGS:
	/* void */

##  gboolean gnome_config_sync (void) 
gboolean
gnome_config_sync (class)
    C_ARGS:
	/* void */

##  void gnome_config_push_prefix (const char *path) 
void
gnome_config_push_prefix (class, path)
	const char *path
    C_ARGS:
	path

##  void gnome_config_pop_prefix (void) 
void
gnome_config_pop_prefix (class)
    C_ARGS:
	/* void */

# --------------------------------------------------------------------------- #

###  void gnome_config_set_vector_ (const char *path, int argc, const char * const argv[], gboolean priv) 
#void
#gnome_config_set_vector_ (path, argc, B, priv)
#	const char *path
#	int argc
#	const char * const argv[]
#	gboolean priv

###  void gnome_config_make_vector (const char *string, int *argcp, char ***argvp) 
#void
#gnome_config_make_vector (string, argcp, argvp)
#	const char *string
#	int *argcp
#	char ***argvp

###  char *gnome_config_assemble_vector (int argc, const char *const argv []) 
#char *
#gnome_config_assemble_vector (argc, )
#	int argc
#	const char *const argv []

# --------------------------------------------------------------------------- #

###  void *gnome_config_init_iterator_ (const char *path, gboolean priv) 
#void *
#gnome_config_init_iterator_ (path, priv)
#	const char *path
#	gboolean priv

###  void *gnome_config_init_iterator_sections_ (const char *path, gboolean priv) 
#void *
#gnome_config_init_iterator_sections_ (path, priv)
#	const char *path
#	gboolean priv

###  void *gnome_config_iterator_next (void *iterator_handle, char **key, char **value) 
#void *
#gnome_config_iterator_next (iterator_handle, key, value)
#	void *iterator_handle
#	char **key
#	char **value
