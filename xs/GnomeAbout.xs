/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::About	PACKAGE = Gnome2::About	PREFIX = gnome_about_


GtkWidget *
gnome_about_new (class, name, version, copyright, comments, authors, documenters=NULL, translator_credits=NULL, logo_pixbuf=NULL)
	SV               * class
	const gchar      * name
	const gchar      * version
	const gchar      * copyright
	const gchar      * comments
	SV               * authors
	SV               * documenters
	const gchar      * translator_credits
	GdkPixbuf_ornull * logo_pixbuf
    PREINIT:
	const gchar ** a = NULL;
	const gchar ** d = NULL;
     CODE:
	/* pull authors and documentors out of the SVs, which may be
	 * either plain strings or refs to arrays of strings */
	if (authors && SvOK(authors)) {
		if (SvRV(authors) && (SvTYPE(SvRV(authors)) == SVt_PVAV)) {
			AV * av = (AV*)SvRV(authors);
			int  i;
			a = g_new0 (const gchar*, av_len(av)+2);

			for(i=0;i<=av_len(av);i++) {
				a[i] = SvPV(*av_fetch(av, i, 0), PL_na);
			}
			a[i] = NULL;
		} else {
			a = (const gchar**)malloc(sizeof(const gchar*) * 2);
			a[0] = SvPV(authors, PL_na);
			a[1] = NULL;
		}
	} else {
		/* the C version of gnome_about_new does not allow authors
		 * to be NULL, and will abort, returning no widget, if
		 * you do pass NULL.  rather than let that slide, let's
		 * croak.  author credits are important, you know! */
		croak ("authors may not be undef, specify either a string or reference to an array of strings"); 
	}
	if (documenters && SvOK(documenters)) {
		if (SvRV(documenters) && (SvTYPE(SvRV(documenters)) == SVt_PVAV)) {
			AV * av = (AV*)SvRV(documenters);
			int  i;
			d = g_new (const gchar*, av_len(av)+2);

			for(i=0;i<=av_len(av);i++) {
				d[i] = SvPV(*av_fetch(av, i, 0), PL_na);
			}
			d[i] = NULL;
		} else {
			d = (const gchar**)malloc(sizeof(const gchar*) * 2);
			d[0] = SvPV(documenters, PL_na);
			d[1] = NULL;
		}
	}
        RETVAL = gnome_about_new (name, version, copyright, comments,
	                          a, d, translator_credits, logo_pixbuf);
	g_free (a);
	g_free (d);
     OUTPUT:
        RETVAL
