#include "gnome2perl.h"

MODULE = Gnome2::Entry	PACKAGE = Gnome2::Entry	PREFIX = gnome_entry_

## GtkWidget * gnome_entry_new (const gchar *history_id) 
GtkWidget *
gnome_entry_new (class, history_id)
	SV * class
	const gchar * history_id
    C_ARGS:
	history_id


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

