/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::FileEntry	PACKAGE = Gnome2::FileEntry	PREFIX = gnome_file_entry_

GtkWidget *
gnome_file_entry_new (class, history_id, browse_dialog_title)
	SV * class
	const char *history_id
	const char *browse_dialog_title
    C_ARGS:
	history_id, browse_dialog_title

GtkWidget * gnome_file_entry_gnome_entry (GnomeFileEntry *fentry);

GtkWidget * gnome_file_entry_gtk_entry (GnomeFileEntry *fentry);

void
gnome_file_entry_set_title (fentry, browse_dialog_title)
	GnomeFileEntry *fentry
	const char *browse_dialog_title

void
gnome_file_entry_set_default_path (fentry, path)
	GnomeFileEntry *fentry
	const char *path

void
gnome_file_entry_set_directory_entry (fentry, directory_entry)
	GnomeFileEntry *fentry
	gboolean directory_entry

gboolean
gnome_file_entry_get_directory_entry (fentry)
	GnomeFileEntry *fentry

char *
gnome_file_entry_get_full_path (fentry, file_must_exist)
	GnomeFileEntry * fentry
	gboolean file_must_exist
    CLEANUP:
	g_free (RETVAL);

void
gnome_file_entry_set_filename (fentry, filename)
	GnomeFileEntry *fentry
	const char *filename

void
gnome_file_entry_set_modal (fentry, is_modal)
	GnomeFileEntry *fentry
	gboolean is_modal

gboolean
gnome_file_entry_get_modal (fentry)
	GnomeFileEntry *fentry


## deprecated
## void gnome_file_entry_set_directory(GnomeFileEntry *fentry, gboolean directory_entry) 
