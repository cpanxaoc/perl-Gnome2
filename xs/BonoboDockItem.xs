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

MODULE = Gnome2::Bonobo::DockItem	PACKAGE = Gnome2::Bonobo::DockItem	PREFIX = bonobo_dock_item_

##  GtkWidget *bonobo_dock_item_new (const gchar *name, BonoboDockItemBehavior behavior) 
GtkWidget *
bonobo_dock_item_new (class, name, behavior)
	SV *class
	const gchar *name
	BonoboDockItemBehavior behavior
    C_ARGS:
	name, behavior

##  GtkWidget *bonobo_dock_item_get_child (BonoboDockItem *dock_item) 
GtkWidget *
bonobo_dock_item_get_child (dock_item)
	BonoboDockItem *dock_item

##  char *bonobo_dock_item_get_name (BonoboDockItem *dock_item) 
char *
bonobo_dock_item_get_name (dock_item)
	BonoboDockItem *dock_item

##  void bonobo_dock_item_set_shadow_type (BonoboDockItem *dock_item, GtkShadowType type) 
void
bonobo_dock_item_set_shadow_type (dock_item, type)
	BonoboDockItem *dock_item
	GtkShadowType type

##  GtkShadowType bonobo_dock_item_get_shadow_type (BonoboDockItem *dock_item) 
GtkShadowType
bonobo_dock_item_get_shadow_type (dock_item)
	BonoboDockItem *dock_item

##  gboolean bonobo_dock_item_set_orientation (BonoboDockItem *dock_item, GtkOrientation orientation) 
gboolean
bonobo_dock_item_set_orientation (dock_item, orientation)
	BonoboDockItem *dock_item
	GtkOrientation orientation

##  GtkOrientation bonobo_dock_item_get_orientation (BonoboDockItem *dock_item) 
GtkOrientation
bonobo_dock_item_get_orientation (dock_item)
	BonoboDockItem *dock_item

##  BonoboDockItemBehavior bonobo_dock_item_get_behavior (BonoboDockItem *dock_item) 
BonoboDockItemBehavior
bonobo_dock_item_get_behavior (dock_item)
	BonoboDockItem *dock_item

##  void bonobo_dock_item_set_locked (BonoboDockItem *dock_item, gboolean locked) 
void
bonobo_dock_item_set_locked (dock_item, locked)
	BonoboDockItem *dock_item
	gboolean locked

##  gboolean bonobo_dock_item_detach (BonoboDockItem *item, gint x, gint y) 
gboolean
bonobo_dock_item_detach (item, x, y)
	BonoboDockItem *item
	gint x
	gint y

##  void bonobo_dock_item_attach (BonoboDockItem *item, GtkWidget *parent, gint x, gint y) 
void
bonobo_dock_item_attach (item, parent, x, y)
	BonoboDockItem *item
	GtkWidget *parent
	gint x
	gint y

##  void bonobo_dock_item_unfloat (BonoboDockItem *item) 
void
bonobo_dock_item_unfloat (item)
	BonoboDockItem *item

##  void bonobo_dock_item_grab_pointer (BonoboDockItem *item) 
void
bonobo_dock_item_grab_pointer (item)
	BonoboDockItem *item

##  void bonobo_dock_item_drag_floating (BonoboDockItem *item, gint x, gint y) 
void
bonobo_dock_item_drag_floating (item, x, y)
	BonoboDockItem *item
	gint x
	gint y

##  void bonobo_dock_item_handle_size_request (BonoboDockItem *item, GtkRequisition *requisition) 
void
bonobo_dock_item_handle_size_request (item, requisition)
	BonoboDockItem *item
	GtkRequisition *requisition

##  void bonobo_dock_item_get_floating_position (BonoboDockItem *item, gint *x, gint *y) 
void
bonobo_dock_item_get_floating_position (BonoboDockItem *item, OUTLIST gint x, OUTLIST gint y)

# FIXME: gcc warns that 'assignment makes pointer from integer without a cast' here.
##  GtkWidget *bonobo_dock_item_get_grip (BonoboDockItem *item) 
GtkWidget *
bonobo_dock_item_get_grip (item)
	BonoboDockItem *item
