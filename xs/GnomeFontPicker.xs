/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::FontPicker	PACKAGE = Gnome2::FontPicker	PREFIX = gnome_font_picker_

GtkWidget *
gnome_font_picker_new (class)
	SV * class
    C_ARGS:
	

## void gnome_font_picker_set_title (GnomeFontPicker *gfp, const gchar *title) 
void
gnome_font_picker_set_title (gfp, title)
	GnomeFontPicker *gfp
	const gchar *title

## GnomeFontPickerMode gnome_font_picker_get_mode (GnomeFontPicker *gfp) 
GnomeFontPickerMode
gnome_font_picker_get_mode (gfp)
	GnomeFontPicker *gfp

## void gnome_font_picker_set_mode (GnomeFontPicker *gfp, GnomeFontPickerMode mode) 
void
gnome_font_picker_set_mode (gfp, mode)
	GnomeFontPicker *gfp
	GnomeFontPickerMode mode

## void gnome_font_picker_fi_set_use_font_in_label (GnomeFontPicker *gfp, gboolean use_font_in_label, gint size) 
void
gnome_font_picker_fi_set_use_font_in_label (gfp, use_font_in_label, size)
	GnomeFontPicker *gfp
	gboolean use_font_in_label
	gint size

## void gnome_font_picker_fi_set_show_size (GnomeFontPicker *gfp, gboolean show_size) 
void
gnome_font_picker_fi_set_show_size (gfp, show_size)
	GnomeFontPicker *gfp
	gboolean show_size

## void gnome_font_picker_uw_set_widget (GnomeFontPicker *gfp, GtkWidget *widget) 
void
gnome_font_picker_uw_set_widget (gfp, widget)
	GnomeFontPicker *gfp
	GtkWidget *widget

## GtkWidget * gnome_font_picker_uw_get_widget (GnomeFontPicker *gfp) 
GtkWidget *
gnome_font_picker_uw_get_widget (gfp)
	GnomeFontPicker *gfp

## GdkFont* gnome_font_picker_get_font (GnomeFontPicker *gfp) 
GdkFont*
gnome_font_picker_get_font (gfp)
	GnomeFontPicker *gfp

## gboolean gnome_font_picker_set_font_name (GnomeFontPicker *gfp, const gchar *fontname) 
gboolean
gnome_font_picker_set_font_name (gfp, fontname)
	GnomeFontPicker *gfp
	const gchar *fontname

## void gnome_font_picker_set_preview_text (GnomeFontPicker *gfp, const gchar *text) 
void
gnome_font_picker_set_preview_text (gfp, text)
	GnomeFontPicker *gfp
	const gchar *text

const gchar* gnome_font_picker_get_preview_text (GnomeFontPicker *gfp);
