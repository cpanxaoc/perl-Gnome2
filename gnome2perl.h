/*
 * Copyright (C) 2003 by the gtk2-perl team (see the file AUTHORS)
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 * $Header$
 */

#ifndef _GNOME2PERL_H_
#define _GNOME2PERL_H_

#include <gtk2perl.h>
#include <vfs2perl.h>

#undef _ /* gnome and perl disagree on this one */

#include <gnome.h>
#include <libgnome/libgnometypebuiltins.h>

#include <libbonobo.h>
#include <libbonoboui.h>
#include <bonobo/bonobo-dock.h>
#include <bonobo/bonobo-dock-item.h>

#include "gnome2perl-version.h"
#include "gnome2perl-autogen.h"

GnomeUIInfo *SvGnomeUIInfo (SV *sv);
char **SvGnomeCharArray (SV *ref);

#endif /* _GNOME2PERL_H_ */
