/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::Druid	PACKAGE = Gnome2::Druid	PREFIX = gnome_druid_

GtkWidget *
buttons (druid)
	GnomeDruid * druid
    ALIAS:
	Gnome2::Druid::help = 0
	Gnome2::Druid::back = 1
	Gnome2::Druid::next = 2
	Gnome2::Druid::cancel = 3
	Gnome2::Druid::finish = 4
    CODE:
	switch (ix) {
		case 0: RETVAL = druid->help; break;
		case 1: RETVAL = druid->back; break;
		case 2: RETVAL = druid->next; break;
		case 3: RETVAL = druid->cancel; break;
		case 4: RETVAL = druid->finish; break;
	}
    OUTPUT:
	RETVAL


GtkWidget *
gnome_druid_new (class)
	SV * class
    C_ARGS:
	

## void gnome_druid_set_buttons_sensitive (GnomeDruid *druid, gboolean back_sensitive, gboolean next_sensitive, gboolean cancel_sensitive, gboolean help_sensitive) 
void
gnome_druid_set_buttons_sensitive (druid, back_sensitive, next_sensitive, cancel_sensitive, help_sensitive)
	GnomeDruid *druid
	gboolean back_sensitive
	gboolean next_sensitive
	gboolean cancel_sensitive
	gboolean help_sensitive

## void gnome_druid_set_show_finish (GnomeDruid *druid, gboolean show_finish) 
void
gnome_druid_set_show_finish (druid, show_finish)
	GnomeDruid *druid
	gboolean show_finish

## void gnome_druid_set_show_help (GnomeDruid *druid, gboolean show_help) 
void
gnome_druid_set_show_help (druid, show_help)
	GnomeDruid *druid
	gboolean show_help

## void gnome_druid_prepend_page (GnomeDruid *druid, GnomeDruidPage *page) 
void
gnome_druid_prepend_page (druid, page)
	GnomeDruid *druid
	GnomeDruidPage *page

## void gnome_druid_insert_page (GnomeDruid *druid, GnomeDruidPage *back_page, GnomeDruidPage *page) 
void
gnome_druid_insert_page (druid, back_page, page)
	GnomeDruid *druid
	GnomeDruidPage_ornull *back_page
	GnomeDruidPage *page

## void gnome_druid_append_page (GnomeDruid *druid, GnomeDruidPage *page) 
void
gnome_druid_append_page (druid, page)
	GnomeDruid *druid
	GnomeDruidPage *page

## void gnome_druid_set_page (GnomeDruid *druid, GnomeDruidPage *page) 
void
gnome_druid_set_page (druid, page)
	GnomeDruid *druid
	GnomeDruidPage *page

## GtkWidget * gnome_druid_new_with_window (const char *title, GtkWindow *parent, gboolean close_on_cancel, GtkWidget **window);
void
gnome_druid_new_with_window (class, title, parent, close_on_cancel)
	SV * class
	const char * title
	GtkWindow_ornull * parent
	gboolean close_on_cancel
    PREINIT:
	GtkWidget * window;
	GtkWidget * druid;
    PPCODE:
	druid = gnome_druid_new_with_window (title, parent, 
	                                     close_on_cancel, &window);
	XPUSHs (sv_2mortal (newSVGnomeDruid (druid)));
	XPUSHs (sv_2mortal (newSVGtkWindow (window)));

