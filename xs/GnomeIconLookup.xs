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

MODULE = Gnome2::IconLookup	PACKAGE = Gnome2::IconTheme	PREFIX = gnome_icon_

# FIXME: need GnomeVFSFileInfo typemap for this.
###  char *gnome_icon_lookup (GnomeIconTheme *icon_theme, GnomeThumbnailFactory *thumbnail_factory, const char *file_uri, const char *custom_icon, GnomeVFSFileInfo *file_info, const char *mime_type, GnomeIconLookupFlags flags, GnomeIconLookupResultFlags *result) 
#char *
#gnome_icon_lookup (icon_theme, thumbnail_factory, file_uri, custom_icon, file_info, mime_type, flags, result)
#	 GnomeIconTheme *icon_theme
#	 GnomeThumbnailFactory *thumbnail_factory
#	 const char *file_uri
#	 const char *custom_icon
#	 GnomeVFSFileInfo *file_info
#	 const char *mime_type
#	 GnomeIconLookupFlags flags
#	 GnomeIconLookupResultFlags *result

# FIXME: we should allow 'undef' for custom_icon.
#        how do you that without manually handling the whole stack?
##  char *gnome_icon_lookup_sync (GnomeIconTheme *icon_theme, GnomeThumbnailFactory *thumbnail_factory, const char *file_uri, const char *custom_icon, GnomeIconLookupFlags flags, GnomeIconLookupResultFlags *result) 
void
gnome_icon_lookup_sync (icon_theme, thumbnail_factory, file_uri, custom_icon, flags)
	GnomeIconTheme *icon_theme
	GnomeThumbnailFactory_ornull *thumbnail_factory
	const char *file_uri
	const char *custom_icon
	GnomeIconLookupFlags flags
    PREINIT:
	GnomeIconLookupResultFlags result;
	char *icon;
    PPCODE:
	icon = gnome_icon_lookup_sync (icon_theme, thumbnail_factory, file_uri, custom_icon, flags, &result);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVpv (icon, PL_na)));
	PUSHs (sv_2mortal (newSVGnomeIconLookupFlags (result)));
