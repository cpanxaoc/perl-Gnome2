#include "gnome2perl.h"

MODULE = Gnome2::About	PACKAGE = Gnome2::About	PREFIX = gnome_about_


GtkWidget *
gnome_about_new (class, name, version, copyright, comments, authors_ref, documenters_ref, translator_credits, logo_pixbuf)
	SV * class
	const gchar * name
	const gchar * version
	const gchar * copyright
	const gchar * comments
	SV * authors_ref
	SV * documenters_ref
	const gchar * translator_credits
	GdkPixbuf_ornull * logo_pixbuf
    PREINIT:
	const gchar **authors = NULL;
	const gchar **documenters = NULL;
    CODE:
	/* FIXME pull authors and documentors out of the SVs, which may be
	 *       either plain strings or refs to arrays of strings */
	RETVAL = gnome_about_new (name, version, copyright, comments,
	                          authors, documenters, translator_credits,
	                          logo_pixbuf);
    OUTPUT:
	RETVAL

