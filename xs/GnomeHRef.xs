#include "gnome2perl.h"

MODULE = Gnome2::HRef	PACKAGE = Gnome2::HRef	PREFIX = gnome_href_

GtkWidget *
gnome_href_new (class, url, text)
	SV * class
	const gchar *url
	const gchar *text
    C_ARGS:
	url, text

void
gnome_href_set_url (href, url)
	GnomeHRef *href
	const gchar *url

const gchar *
gnome_href_get_url (href)
	GnomeHRef * href

void
gnome_href_set_text (href, text)
	GnomeHRef *href
	const gchar *text

const gchar *
gnome_href_get_text (href)
	GnomeHRef * href

void
gnome_href_set_label (href, label)
	GnomeHRef *href
	const gchar *label

const gchar *
gnome_href_get_label (href)
	GnomeHRef * href
