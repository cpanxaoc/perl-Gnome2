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

MODULE = Gnome2::App	PACKAGE = Gnome2::App	PREFIX = gnome_app_

##struct _GnomeApp {
##	GtkWindow parent_object;
##
##	/* Application name. */
##	gchar *name;
##
##	/* Prefix for gnome-config (used to save the layout).  */
##	gchar *prefix;
##
##        /* The dock.  */
##        GtkWidget *dock;
##
##	/* The status bar.  */
##        GtkWidget *statusbar;
##
##	/* The vbox widget that ties them.  */
##	GtkWidget *vbox;
##
##	/* The menubar.  This is a pointer to a widget contained into
##           the dock.  */
##	GtkWidget *menubar;
##
##	/* The contents.  This is a pointer to dock->client_area.  */
##	GtkWidget *contents;
##
##	/* Dock layout.  */
##	BonoboDockLayout *layout;
##
##	/* Main accelerator group for this window (hotkeys live here).  */
##	GtkAccelGroup *accel_group;
##
##	/* If TRUE, the application uses gnome-config to retrieve and
##           save the docking configuration automagically.  */
##	guint enable_layout_config : 1;
##
##	/*< private >*/
##	GnomeAppPrivate *_priv;
##};


## Create a new (empty) application window.  You must specify the application's
## name (used internally as an identifier).  The window title can be left as
## NULL, in which case the window's title will not be set.
GtkWidget *gnome_app_new (SV * class, const gchar *appname, const gchar *title=NULL)
    C_ARGS:
	appname, title

## Sets the menu bar of the application window
void gnome_app_set_menus (GnomeApp *app, GtkMenuBar *menubar);

## Sets the main toolbar of the application window
void gnome_app_set_toolbar (GnomeApp *app, GtkToolbar *toolbar);

## Sets the status bar of the application window
void gnome_app_set_statusbar (GnomeApp *app, GtkWidget *statusbar);

## Sets the status bar of the application window, but uses the given
## container widget rather than creating a new one.
void gnome_app_set_statusbar_custom (GnomeApp *app, GtkWidget *container, GtkWidget *statusbar);

### Sets the content area of the application window 
void gnome_app_set_contents (GnomeApp *app, GtkWidget *contents);

### TODO these require bonobo typemaps
##void gnome_app_add_toolbar (GnomeApp *app,
##			    GtkToolbar *toolbar,
##			    const gchar *name,
##			    BonoboDockItemBehavior behavior,
##			    BonoboDockPlacement placement,
##			    gint band_num,
##			    gint band_position,
##			    gint offset);
##
##GtkWidget *gnome_app_add_docked (GnomeApp *app,
##				 GtkWidget *widget,
##				 const gchar *name,
##				 BonoboDockItemBehavior behavior,
##				 BonoboDockPlacement placement,
##				 gint band_num,
##				 gint band_position,
##				 gint offset);
##
##void gnome_app_add_dock_item (GnomeApp *app,
##			      BonoboDockItem *item,
##			      BonoboDockPlacement placement,
##			      gint band_num,
##			      gint band_position,
##			      gint offset);

void gnome_app_enable_layout_config (GnomeApp *app, gboolean enable);

### TODO these require bonobo typemaps
#
##BonoboDock *gnome_app_get_dock (GnomeApp *app);
##
##BonoboDockItem *gnome_app_get_dock_item_by_name (GnomeApp *app, const gchar *name);

