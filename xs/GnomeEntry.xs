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

MODULE = Gnome2::Entry	PACKAGE = Gnome2::Entry	PREFIX = gnome_entry_

## GtkWidget * gnome_entry_new (const gchar *history_id) 
GtkWidget *
gnome_entry_new (class, history_id=NULL)
	SV * class
	const gchar * history_id
    C_ARGS:
	history_id

GtkWidget *
gnome_entry_gtk_entry (gentry)
	GnomeEntry *gentry

const gchar *
gnome_entry_get_history_id (gentry)
	GnomeEntry *gentry

void
gnome_entry_set_history_id (gentry, history_id)
	GnomeEntry *gentry
	const gchar *history_id

void
gnome_entry_set_max_saved (gentry, max_saved)
	GnomeEntry *gentry
	guint max_saved

guint
gnome_entry_get_max_saved (gentry)
	GnomeEntry *gentry

void
gnome_entry_prepend_history (gentry, save, text)
	GnomeEntry *gentry
	gboolean save
	const gchar *text

void
gnome_entry_append_history (gentry, save, text)
	GnomeEntry *gentry
	gboolean save
	const gchar *text

void
gnome_entry_clear_history (gentry)
	GnomeEntry *gentry

