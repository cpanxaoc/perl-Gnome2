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

extern void gtk2perl_menu_position_func (GtkMenu       * menu,
                                         gint          * x,
                                         gint          * y,
                                         gboolean      * push_in,
                                         GPerlCallback * callback);

MODULE = Gnome2::PopupMenu	PACKAGE = Gnome2::PopupMenu	PREFIX = gnome_popup_menu_

##  GtkWidget *gnome_popup_menu_new (GnomeUIInfo *uiinfo) 
##  GtkWidget *gnome_popup_menu_new_with_accelgroup (GnomeUIInfo *uiinfo, GtkAccelGroup *accelgroup) 
GtkWidget *
gnome_popup_menu_new (class, uiinfo, accelgroup=NULL)
	SV * class
	GnomeUIInfo *uiinfo
	GtkAccelGroup *accelgroup
    ALIAS:
	new_with_accelgroup = 1
    CODE:
	if (ix == 1 || accelgroup != NULL)
		RETVAL = gnome_popup_menu_new_with_accelgroup (uiinfo,
		                                               accelgroup);
	else
		RETVAL = gnome_popup_menu_new (uiinfo);
    OUTPUT:
	RETVAL

MODULE = Gnome2::PopupMenu	PACKAGE = Gtk2::Menu	PREFIX = gnome_popup_menu_

## same as gtk_menu_get_accel_group
##  GtkAccelGroup *gnome_popup_menu_get_accel_group(GtkMenu *menu) 

## FIXME -- this user_data is to be attached to the menu in a way that it will
##          be passed to the callback function when it gets called.  how are
##          we to get this stuff to go through the type mechanism the way we
##          expect?:  reimplement in perl?:  (or maybe even in xs...)
##  void gnome_popup_menu_attach (GtkWidget *popup, GtkWidget *widget, gpointer user_data) 
void
gnome_popup_menu_attach (popup, widget, user_data=NULL)
	GtkWidget *popup
	GtkWidget *widget
	SV * user_data
    CODE:
	if (SvTRUE (user_data))
		warn ("FIXME you passed something other than undef for "
		      "user_data to gnome_popup_menu_attach, but i don't "
		      "know how to get that through properly.  if you can't "
		      "live without this functionality, email somebody on "
		      "the authors list.  ignoring user_data");
	gnome_popup_menu_attach (popup, widget, NULL);

####  void gnome_popup_menu_do_popup (GtkWidget *popup, GtkMenuPositionFunc pos_func, gpointer pos_data, GdkEventButton *event, gpointer user_data, GtkWidget *for_widget) 
void
gnome_popup_menu_do_popup (popup, pos_func, pos_data, event, user_data, for_widget)
	GtkMenu * popup
	SV * pos_func
	SV * pos_data
	GdkEvent * event
	SV * user_data
	GtkWidget * for_widget
    CODE:
	if (SvTRUE (user_data))
		warn ("FIXME you passed something other than undef for "
		      "user_data to gnome_popup_menu_do_popup, but i don't "
		      "know how to get that through properly.  if you can't "
		      "live without this functionality, email somebody on "
		      "the authors list.  ignoring user_data");
	if (SvTRUE (pos_func)) {
		GPerlCallback * callback;
		/* we don't need to worry about the callback arg types since
		 * we already have to marshall this callback ourselves. */
		callback = gperl_callback_new (pos_func, pos_data, 0, NULL, 0);
		gnome_popup_menu_do_popup (GTK_WIDGET (popup),
		                           (GtkMenuPositionFunc)
		                                 gtk2perl_menu_position_func,
		                           callback, (GdkEventButton*) event,
		                           user_data, for_widget);
		/* NOTE: this isn't a proper destructor, as it could leak
		 *    if replaced somewhere else.  on the other hand, how
		 *    likely is that? */
		g_object_set_data_full (G_OBJECT (popup), "_menu_pos_callback",
		                        callback,
		                        (GDestroyNotify)
		                             gperl_callback_destroy);
	} else
		gnome_popup_menu_do_popup (GTK_WIDGET (popup), NULL, NULL,
		                           (GdkEventButton*) event,
		                           user_data, for_widget);


####  int gnome_popup_menu_do_popup_modal (GtkWidget *popup, GtkMenuPositionFunc pos_func, gpointer pos_data, GdkEventButton *event, gpointer user_data, GtkWidget *for_widget) 
int
gnome_popup_menu_do_popup_modal (popup, pos_func, pos_data, event, user_data, for_widget)
	GtkMenu * popup
	SV * pos_func
	SV * pos_data
	GdkEvent * event
	SV * user_data
	GtkWidget * for_widget
    CODE:
	if (SvTRUE (user_data))
		warn ("FIXME you passed something other than undef for "
		      "user_data to gnome_popup_menu_do_popup_modal, but i "
		      "don't know how to get that through properly.  if you "
		      "can't live without this functionality, email somebody "
		      "on the authors list.  ignoring user_data");
	if (SvTRUE (pos_func)) {
		GPerlCallback * callback;
		/* we don't need to worry about the callback arg types since
		 * we already have to marshall this callback ourselves. */
		callback = gperl_callback_new (pos_func, pos_data, 0, NULL, 0);
		RETVAL = gnome_popup_menu_do_popup_modal (GTK_WIDGET (popup),
		                      (GtkMenuPositionFunc)
		                            gtk2perl_menu_position_func,
		                      callback, (GdkEventButton *) event,
		                      user_data, for_widget);
		gperl_callback_destroy (callback);
	} else
		RETVAL = gnome_popup_menu_do_popup_modal
		                        (GTK_WIDGET (popup), NULL, NULL,
		                        (GdkEventButton*) event, user_data,
		                        for_widget);
    OUTPUT:
	RETVAL

##  void gnome_popup_menu_append (GtkWidget *popup, GnomeUIInfo *uiinfo) 
void
gnome_popup_menu_append (popup, uiinfo)
	GtkWidget *popup
	GnomeUIInfo *uiinfo

MODULE = Gnome2::PopupMenu	PACKAGE = Gtk2::Widget	PREFIX = gnome_gtk_widget_

##  void gnome_gtk_widget_add_popup_items (GtkWidget *widget, GnomeUIInfo *uiinfo, gpointer user_data) 
void
gnome_gtk_widget_add_popup_items (widget, uiinfo, user_data=NULL)
	GtkWidget *widget
	GnomeUIInfo *uiinfo
	SV * user_data
    CODE:
	if (SvTRUE (user_data))
		warn ("FIXME you passed something other than undef for "
		      "user_data to gnome_popup_menu_popup_items, but i "
		      "don't know how to get that through properly.  if you "
		      "can't live without this functionality, email somebody "
		      "on the authors list.  ignoring user_data");
	gnome_gtk_widget_add_popup_items (widget, uiinfo, NULL);
