/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::DruidPageStandard	PACKAGE = Gnome2::DruidPageStandard	PREFIX = gnome_druid_page_standard_

## GtkWidget*  gnome_druid_page_standard_new   (void);
GtkWidget * 
gnome_druid_page_standard_new (class)
	SV * class
    C_ARGS:
	

## GtkWidget*  gnome_druid_page_standard_new_with_vals (const gchar *title, GdkPixbuf *logo, GdkPixbuf *top_watermark);
GtkWidget *
gnome_druid_page_standard_new_with_vals (class, title, logo, top_watermark)
	SV * class
	const gchar *title
	GdkPixbuf_ornull *logo
	GdkPixbuf_ornull *top_watermark
    C_ARGS:
	title, logo, top_watermark

## void gnome_druid_page_standard_set_title (GnomeDruidPageStandard *druid_page_standard, const gchar *title) 
void
gnome_druid_page_standard_set_title (druid_page_standard, title)
	GnomeDruidPageStandard *druid_page_standard
	const gchar *title

## void gnome_druid_page_standard_set_logo (GnomeDruidPageStandard *druid_page_standard, GdkPixbuf *logo_image) 
void
gnome_druid_page_standard_set_logo (druid_page_standard, logo_image)
	GnomeDruidPageStandard *druid_page_standard
	GdkPixbuf_ornull *logo_image

## void gnome_druid_page_standard_set_top_watermark (GnomeDruidPageStandard *druid_page_standard, GdkPixbuf *top_watermark_image) 
void
gnome_druid_page_standard_set_top_watermark (druid_page_standard, top_watermark_image)
	GnomeDruidPageStandard *druid_page_standard
	GdkPixbuf_ornull *top_watermark_image

## void gnome_druid_page_standard_set_title_foreground (GnomeDruidPageStandard *druid_page_standard, GdkColor *color) 
void
gnome_druid_page_standard_set_title_foreground (druid_page_standard, color)
	GnomeDruidPageStandard *druid_page_standard
	GdkColor *color

## void gnome_druid_page_standard_set_background (GnomeDruidPageStandard *druid_page_standard, GdkColor *color) 
void
gnome_druid_page_standard_set_background (druid_page_standard, color)
	GnomeDruidPageStandard *druid_page_standard
	GdkColor *color

## void gnome_druid_page_standard_set_logo_background (GnomeDruidPageStandard *druid_page_standard, GdkColor *color) 
void
gnome_druid_page_standard_set_logo_background (druid_page_standard, color)
	GnomeDruidPageStandard *druid_page_standard
	GdkColor *color

## void gnome_druid_page_standard_set_contents_background (GnomeDruidPageStandard *druid_page_standard, GdkColor *color) 
void
gnome_druid_page_standard_set_contents_background (druid_page_standard, color)
	GnomeDruidPageStandard *druid_page_standard
	GdkColor *color

## void gnome_druid_page_standard_append_item (GnomeDruidPageStandard *druid_page_standard, const gchar *question, GtkWidget *item, const gchar *additional_info) 
void
gnome_druid_page_standard_append_item (druid_page_standard, question, item, additional_info)
	GnomeDruidPageStandard *druid_page_standard
	const gchar *question
	GtkWidget *item
	const gchar *additional_info

