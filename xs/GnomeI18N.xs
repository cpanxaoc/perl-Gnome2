/*
 * Copyright (c) 2003 by the gtk2-perl team (see the file AUTHORS)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Library General Public License for more details.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this library; if not, write to the 
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330, 
 * Boston, MA  02111-1307  USA.
 *
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::I18N	PACKAGE = Gnome2::I18N	PREFIX = gnome_i18n_

##  const GList * gnome_i18n_get_language_list (const gchar *category_name)
void
gnome_i18n_get_language_list (class, category_name=NULL)
	SV *class
	const gchar *category_name
    PREINIT:
	const GList *results;
    PPCODE:
	results = gnome_i18n_get_language_list (category_name);
	for ( ; results != NULL; results = results->next)
		XPUSHs (sv_2mortal (newSVpv (results->data, PL_na)));

##  void gnome_i18n_push_c_numeric_locale (void) 
void
gnome_i18n_push_c_numeric_locale (class)
	SV *class
    C_ARGS:
	/* void */

##  void gnome_i18n_pop_c_numeric_locale (void) 
void
gnome_i18n_pop_c_numeric_locale (class)
	SV *class
    C_ARGS:
	/* void */

