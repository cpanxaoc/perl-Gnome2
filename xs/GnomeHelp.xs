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

#include "gnome2perl.h"

MODULE = Gnome2::Help	PACKAGE = Gnome2::Help	PREFIX = gnome_help_

##  gboolean gnome_help_display (const char *file_name, const char *link_id, GError **error) 
gboolean
gnome_help_display (class, file_name, link_id=NULL)
	const char *file_name
	const char *link_id
    PREINIT:
	GError *error = NULL;
    CODE:
	RETVAL = gnome_help_display (file_name, link_id, &error);
	if (!RETVAL)
		gperl_croak_gerror("Gnome2::Help->display", error);
    OUTPUT:
	RETVAL

# API docs: «Most of the time, you want to call gnome_help_display() instead.»
###  gboolean gnome_help_display_with_doc_id (GnomeProgram *program, const char *doc_id, const char *file_name, const char *link_id, GError **error) 
#gboolean
#gnome_help_display_with_doc_id (program, doc_id, file_name, link_id, error)
#	GnomeProgram *program
#	const char *doc_id
#	const char *file_name
#	const char *link_id
#	GError **error

###  gboolean gnome_help_display_with_doc_id_and_env (GnomeProgram *program, const char *doc_id, const char *file_name, const char *link_id, char **envp, GError **error) 
#gboolean
#gnome_help_display_with_doc_id_and_env (program, doc_id, file_name, link_id, envp, error)
#	GnomeProgram *program
#	const char *doc_id
#	const char *file_name
#	const char *link_id
#	char **envp
#	GError **error

# API docs: «You should never need to call this function directly in code [...]»
###  gboolean gnome_help_display_uri (const char *help_uri, GError **error) 
#gboolean
#gnome_help_display_uri (class, help_uri)
#	const char *help_uri
#    PREINIT:
#	GError *error = NULL;
#    CODE:
#	RETVAL = gnome_help_display_uri (help_uri, &error);
#	iif (!RETVAL)
#		gperl_croak_gerror("Gnome2::Help->display_uri", error);
#    OUTPUT:
#	RETVAL

###  gboolean gnome_help_display_uri_with_env (const char *help_uri, char **envp, GError **error) 
#gboolean
#gnome_help_display_uri_with_env (help_uri, envp, error)
#	const char *help_uri
#	char **envp
#	GError **error

##  gboolean gnome_help_display_desktop (GnomeProgram *program, const char *doc_id, const char *file_name, const char *link_id, GError **error) 
gboolean
gnome_help_display_desktop (class, program, doc_id, file_name, link_id=NULL)
	GnomeProgram_ornull *program
	const char *doc_id
	const char *file_name
	const char *link_id
    PREINIT:
	GError *error = NULL;
    CODE:
	RETVAL = gnome_help_display_desktop (program, doc_id, file_name, link_id, &error);
	if (!RETVAL)
		gperl_croak_gerror("Gnome2::Help->display_desktop", error);
    OUTPUT:
	RETVAL

###  gboolean gnome_help_display_desktop_with_env (GnomeProgram *program, const char *doc_id, const char *file_name, const char *link_id, char **envp, GError **error) 
#gboolean
#gnome_help_display_desktop_with_env (program, doc_id, file_name, link_id, envp, error)
#	GnomeProgram *program
#	const char *doc_id
#	const char *file_name
#	const char *link_id
#	char **envp
#	GError **error

