#include "gnome2perl.h"

MODULE = Gnome2::DruidPage	PACKAGE = Gnome2::DruidPage	PREFIX = gnome_druid_page_

GtkWidget *
gnome_druid_page_new (class)
	SV * class
    C_ARGS:
	

gboolean
gnome_druid_page_next (druid_page)
	GnomeDruidPage *druid_page

void
gnome_druid_page_prepare (druid_page)
	GnomeDruidPage *druid_page

gboolean
gnome_druid_page_back (druid_page)
	GnomeDruidPage *druid_page

gboolean
gnome_druid_page_cancel (druid_page)
	GnomeDruidPage *druid_page

void
gnome_druid_page_finish (druid_page)
	GnomeDruidPage *druid_page

