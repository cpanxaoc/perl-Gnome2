#include "gnome2perl.h"

MODULE = Gnome2::AppBar	PACKAGE = Gnome2::AppBar	PREFIX = gnome_appbar_

## GtkWidget* gnome_appbar_new (gboolean has_progress, gboolean has_status, GnomePreferencesType interactivity) 
GtkWidget*
gnome_appbar_new (class, has_progress, has_status, interactivity)
	SV * class
	gboolean has_progress
	gboolean has_status
	GnomePreferencesType interactivity
    C_ARGS:
	has_progress, has_status, interactivity

## void gnome_appbar_set_status (GnomeAppBar * appbar, const gchar * status) 
void
gnome_appbar_set_status (appbar, status)
	GnomeAppBar * appbar
	const gchar * status

## GtkWidget* gnome_appbar_get_status (GnomeAppBar * appbar) 
GtkWidget*
gnome_appbar_get_status (appbar)
	GnomeAppBar * appbar

## void gnome_appbar_set_default (GnomeAppBar * appbar, const gchar * default_status) 
void
gnome_appbar_set_default (appbar, default_status)
	GnomeAppBar * appbar
	const gchar * default_status

## void gnome_appbar_push (GnomeAppBar * appbar, const gchar * status) 
void
gnome_appbar_push (appbar, status)
	GnomeAppBar * appbar
	const gchar * status

## void gnome_appbar_pop (GnomeAppBar * appbar) 
void
gnome_appbar_pop (appbar)
	GnomeAppBar * appbar

## void gnome_appbar_clear_stack (GnomeAppBar * appbar) 
void
gnome_appbar_clear_stack (appbar)
	GnomeAppBar * appbar

## void gnome_appbar_set_progress_percentage (GnomeAppBar *appbar, gfloat percentage) 
void
gnome_appbar_set_progress_percentage (appbar, percentage)
	GnomeAppBar *appbar
	gfloat percentage

## GtkProgressBar* gnome_appbar_get_progress (GnomeAppBar * appbar) 
GtkProgressBar*
gnome_appbar_get_progress (appbar)
	GnomeAppBar * appbar

## void gnome_appbar_refresh (GnomeAppBar * appbar) 
void
gnome_appbar_refresh (appbar)
	GnomeAppBar * appbar

## void gnome_appbar_set_prompt (GnomeAppBar * appbar, const gchar * prompt, gboolean modal) 
void
gnome_appbar_set_prompt (appbar, prompt, modal)
	GnomeAppBar * appbar
	const gchar * prompt
	gboolean modal

## void gnome_appbar_clear_prompt (GnomeAppBar * appbar) 
void
gnome_appbar_clear_prompt (appbar)
	GnomeAppBar * appbar

## gchar * gnome_appbar_get_response (GnomeAppBar * appbar) 
gchar *
gnome_appbar_get_response (appbar)
	GnomeAppBar * appbar

