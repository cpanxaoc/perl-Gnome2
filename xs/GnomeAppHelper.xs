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

/*
FIXME need typedef for GnomeUIInfo
*/

/* typedef void (* GnomeUISignalConnectFunc) (GnomeUIInfo *uiinfo, const char *signal_name, GnomeUIBuilderData *uibdata)  */

MODULE = Gnome2::AppHelper	PACKAGE = Gnome2	PREFIX = gnome_

## void gnome_accelerators_sync (void) 
void
gnome_accelerators_sync (class)
	SV * class
    C_ARGS:
	

MODULE = Gnome2::AppHelper	PACKAGE = Gnome2::App	PREFIX = gnome_app_

### void gnome_app_fill_menu (GtkMenuShell *menu_shell, GnomeUIInfo *uiinfo, GtkAccelGroup *accel_group, gboolean uline_accels, gint pos) 
#void
#gnome_app_fill_menu (menu_shell, uiinfo, accel_group, uline_accels, pos)
#	GtkMenuShell *menu_shell
#	GnomeUIInfo *uiinfo
#	GtkAccelGroup *accel_group
#	gboolean uline_accels
#	gint pos
#
### void gnome_app_fill_menu_with_data (GtkMenuShell *menu_shell, GnomeUIInfo *uiinfo, GtkAccelGroup *accel_group, gboolean uline_accels, gint pos, gpointer user_data) 
#void
#gnome_app_fill_menu_with_data (class, menu_shell, uiinfo, accel_group, uline_accels, pos, user_data)
#	SV * class
#	GtkMenuShell *menu_shell
#	GnomeUIInfo *uiinfo
#	GtkAccelGroup *accel_group
#	gboolean uline_accels
#	gint pos
#	gpointer user_data
#
### void gnome_app_fill_menu_custom (GtkMenuShell *menu_shell, GnomeUIInfo *uiinfo, GnomeUIBuilderData *uibdata, GtkAccelGroup *accel_group, gboolean uline_accels, gint pos) 
#void
#gnome_app_fill_menu_custom (class, menu_shell, uiinfo, uibdata, accel_group, uline_accels, pos)
#	SV * class
#	GtkMenuShell *menu_shell
#	GnomeUIInfo *uiinfo
#	GnomeUIBuilderData *uibdata
#	GtkAccelGroup *accel_group
#	gboolean uline_accels
#	gint pos
#
#### void gnome_app_ui_configure_configurable (GnomeUIInfo* uiinfo) 
##void
##gnome_app_ui_configure_configurable (uiinfo)
##	GnomeUIInfo* uiinfo
#
### void gnome_app_create_menus (GnomeApp *app, GnomeUIInfo *uiinfo) 
#void
#gnome_app_create_menus (app, uiinfo)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#
### void gnome_app_create_menus_interp (GnomeApp *app, GnomeUIInfo *uiinfo, GtkCallbackMarshal relay_func, gpointer data, GtkDestroyNotify destroy_func) 
#void
#gnome_app_create_menus_interp (app, uiinfo, relay_func, data, destroy_func)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#	GtkCallbackMarshal relay_func
#	gpointer data
#	GtkDestroyNotify destroy_func
#
### void gnome_app_create_menus_with_data (GnomeApp *app, GnomeUIInfo *uiinfo, gpointer user_data) 
#void
#gnome_app_create_menus_with_data (app, uiinfo, user_data)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#	gpointer user_data
#
### void gnome_app_create_menus_custom (GnomeApp *app, GnomeUIInfo *uiinfo, GnomeUIBuilderData *uibdata) 
#void
#gnome_app_create_menus_custom (app, uiinfo, uibdata)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#	GnomeUIBuilderData *uibdata
#
### void gnome_app_fill_toolbar (GtkToolbar *toolbar, GnomeUIInfo *uiinfo, GtkAccelGroup *accel_group) 
#void
#gnome_app_fill_toolbar (class, toolbar, uiinfo, accel_group)
#	SV * class
#	GtkToolbar *toolbar
#	GnomeUIInfo *uiinfo
#	GtkAccelGroup *accel_group
#
### void gnome_app_fill_toolbar_with_data (GtkToolbar *toolbar, GnomeUIInfo *uiinfo, GtkAccelGroup *accel_group, gpointer user_data) 
#void
#gnome_app_fill_toolbar_with_data (class, toolbar, uiinfo, accel_group, user_data)
#	SV * class
#	GtkToolbar *toolbar
#	GnomeUIInfo *uiinfo
#	GtkAccelGroup *accel_group
#	gpointer user_data
#
### void gnome_app_fill_toolbar_custom (GtkToolbar *toolbar, GnomeUIInfo *uiinfo, GnomeUIBuilderData *uibdata, GtkAccelGroup *accel_group) 
#void
#gnome_app_fill_toolbar_custom (class, toolbar, uiinfo, uibdata, accel_group)
#	SV * class
#	GtkToolbar *toolbar
#	GnomeUIInfo *uiinfo
#	GnomeUIBuilderData *uibdata
#	GtkAccelGroup *accel_group
#
### void gnome_app_create_toolbar (GnomeApp *app, GnomeUIInfo *uiinfo) 
#void
#gnome_app_create_toolbar (app, uiinfo)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#
### void gnome_app_create_toolbar_interp (GnomeApp *app, GnomeUIInfo *uiinfo, GtkCallbackMarshal relay_func, gpointer data, GtkDestroyNotify destroy_func) 
#void
#gnome_app_create_toolbar_interp (app, uiinfo, relay_func, data, destroy_func)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#	GtkCallbackMarshal relay_func
#	gpointer data
#	GtkDestroyNotify destroy_func
#
### void gnome_app_create_toolbar_with_data (GnomeApp *app, GnomeUIInfo *uiinfo, gpointer user_data) 
#void
#gnome_app_create_toolbar_with_data (app, uiinfo, user_data)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#	gpointer user_data
#
### void gnome_app_create_toolbar_custom (GnomeApp *app, GnomeUIInfo *uiinfo, GnomeUIBuilderData *uibdata) 
#void
#gnome_app_create_toolbar_custom (app, uiinfo, uibdata)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#	GnomeUIBuilderData *uibdata
#
### void gnome_app_remove_menus (GnomeApp *app, const gchar *path, gint items) 
#void
#gnome_app_remove_menus (app, path, items)
#	GnomeApp *app
#	const gchar *path
#	gint items
#
### void gnome_app_remove_menu_range (GnomeApp *app, const gchar *path, gint start, gint items) 
#void
#gnome_app_remove_menu_range (app, path, start, items)
#	GnomeApp *app
#	const gchar *path
#	gint start
#	gint items
#
### void gnome_app_insert_menus_custom (GnomeApp *app, const gchar *path, GnomeUIInfo *uiinfo, GnomeUIBuilderData *uibdata) 
#void
#gnome_app_insert_menus_custom (app, path, uiinfo, uibdata)
#	GnomeApp *app
#	const gchar *path
#	GnomeUIInfo *uiinfo
#	GnomeUIBuilderData *uibdata
#
### void gnome_app_insert_menus (GnomeApp *app, const gchar *path, GnomeUIInfo *menuinfo) 
#void
#gnome_app_insert_menus (app, path, menuinfo)
#	GnomeApp *app
#	const gchar *path
#	GnomeUIInfo *menuinfo
#
### void gnome_app_insert_menus_with_data (GnomeApp *app, const gchar *path, GnomeUIInfo *menuinfo, gpointer data) 
#void
#gnome_app_insert_menus_with_data (app, path, menuinfo, data)
#	GnomeApp *app
#	const gchar *path
#	GnomeUIInfo *menuinfo
#	gpointer data
#
### void gnome_app_insert_menus_interp (GnomeApp *app, const gchar *path, GnomeUIInfo *menuinfo, GtkCallbackMarshal relay_func, gpointer data, GtkDestroyNotify destroy_func) 
#void
#gnome_app_insert_menus_interp (app, path, menuinfo, relay_func, data, destroy_func)
#	GnomeApp *app
#	const gchar *path
#	GnomeUIInfo *menuinfo
#	GtkCallbackMarshal relay_func
#	gpointer data
#	GtkDestroyNotify destroy_func
#
### void gnome_app_install_appbar_menu_hints (GnomeAppBar* appbar, GnomeUIInfo* uiinfo) 
#void
#gnome_app_install_appbar_menu_hints (class, appbar, uiinfo)
#	SV * class
#	GnomeAppBar* appbar
#	GnomeUIInfo* uiinfo
#
### void gnome_app_install_statusbar_menu_hints (GtkStatusbar* bar, GnomeUIInfo* uiinfo) 
#void
#gnome_app_install_statusbar_menu_hints (class, bar, uiinfo)
#	SV * class
#	GtkStatusbar* bar
#	GnomeUIInfo* uiinfo
#
### void gnome_app_install_menu_hints (GnomeApp *app, GnomeUIInfo *uiinfo) 
#void
#gnome_app_install_menu_hints (app, uiinfo)
#	GnomeApp *app
#	GnomeUIInfo *uiinfo
#
## FIXME need bonobo stuff for this
#### void gnome_app_setup_toolbar (GtkToolbar *toolbar, BonoboDockItem *dock_item) 
##void
##gnome_app_setup_toolbar (toolbar, dock_item)
##	GtkToolbar *toolbar
##	BonoboDockItem *dock_item

