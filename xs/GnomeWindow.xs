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

/* the stuff in gnome-window.h was deprecated as of Oct '03 */
#undef GNOME_DISABLE_DEPRECATED

#include "gnome2perl.h"
#include <libgnomeui/gnome-window.h>

MODULE = Gnome2::Window	PACKAGE = Gtk2::Window	PREFIX = gnome_window_

=for object Gnome2::Window
=cut

##  void gnome_window_toplevel_set_title (GtkWindow *window, const gchar *doc_name, const gchar *app_name, const gchar *extension) 
void
gnome_window_toplevel_set_title (window, doc_name, app_name, extension)
	GtkWindow *window
	const gchar *doc_name
	const gchar *app_name
	const gchar *extension
    C_ARGS:
	window, doc_name, app_name, extension

