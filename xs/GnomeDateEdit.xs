/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::DateEdit	PACKAGE = Gnome2::DateEdit	PREFIX = gnome_date_edit_

GtkWidget *
gnome_date_edit_new (class, the_time, show_time, use_24_format)
	SV * class
	time_t the_time
	gboolean show_time
	gboolean use_24_format
    C_ARGS:
	the_time, show_time, use_24_format

GtkWidget *
gnome_date_edit_new_flags (class, the_time, flags)
	SV * class
	time_t the_time
	GnomeDateEditFlags flags
    C_ARGS:
	the_time, flags

## void gnome_date_edit_set_time (GnomeDateEdit *gde, time_t the_time) 
void
gnome_date_edit_set_time (gde, the_time)
	GnomeDateEdit *gde
	time_t the_time

## time_t gnome_date_edit_get_time (GnomeDateEdit *gde) 
time_t
gnome_date_edit_get_time (gde)
	GnomeDateEdit *gde

## void gnome_date_edit_set_popup_range (GnomeDateEdit *gde, int low_hour, int up_hour) 
void
gnome_date_edit_set_popup_range (gde, low_hour, up_hour)
	GnomeDateEdit *gde
	int low_hour
	int up_hour

## void gnome_date_edit_set_flags (GnomeDateEdit *gde, GnomeDateEditFlags flags) 
void
gnome_date_edit_set_flags (gde, flags)
	GnomeDateEdit *gde
	GnomeDateEditFlags flags

## int gnome_date_edit_get_flags (GnomeDateEdit *gde) 
int
gnome_date_edit_get_flags (gde)
	GnomeDateEdit *gde

## time_t gnome_date_edit_get_initial_time(GnomeDateEdit *gde) 
time_t
gnome_date_edit_get_initial_time (gde)
	GnomeDateEdit *gde

