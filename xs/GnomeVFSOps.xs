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

GnomeVFSHandle *
SvGnomeVFSHandle (SV *object)
{
	GnomeVFSHandle *handle;
	MAGIC *mg;

	if (!object || !SvOK (object) || !SvROK (object) || !(mg = mg_find (SvRV (object), PERL_MAGIC_ext)))
		return NULL;

	return (GnomeVFSHandle *) mg->mg_ptr;
}

SV *
newSVGnomeVFSHandle (GnomeVFSHandle *handle) {
	SV *object = (SV *) newHV ();

	sv_magic (object, 0, PERL_MAGIC_ext, (const char *) handle, 0);

	return object;
}

SV *
handle_to_object (GnomeVFSHandle *handle) {
	SV *rv;
	HV *stash;

	rv = newRV (newSVGnomeVFSHandle (handle));
	stash = gv_stashpv ("Gnome2::VFS::Handle", 1);

	return sv_bless (rv, stash);
}

MODULE = Gnome2::VFS::Ops	PACKAGE = Gnome2::VFS	PREFIX = gnome_vfs_

void
DESTROY (object)
	SV *object
    CODE:
	MAGIC *mg;

	if (!object || !SvOK (object) || !SvROK (object) || !(mg = mg_find (SvRV (object), PERL_MAGIC_ext)))
		return;

	sv_unmagic (SvRV (object), PERL_MAGIC_ext);

##  GnomeVFSResult gnome_vfs_open (GnomeVFSHandle **handle, const gchar *text_uri, GnomeVFSOpenMode open_mode)
void
gnome_vfs_open (class, text_uri, open_mode)
	SV *class
	const gchar *text_uri
	GnomeVFSOpenMode open_mode
    PREINIT:
	GnomeVFSResult result;
	GnomeVFSHandle *handle;
    PPCODE:
	result = gnome_vfs_open (&handle, text_uri, open_mode);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGnomeVFSResult (result)));
	PUSHs (sv_2mortal (handle_to_object (handle)));

##  GnomeVFSResult gnome_vfs_open_uri (GnomeVFSHandle **handle, GnomeVFSURI *uri, GnomeVFSOpenMode open_mode) 
void
gnome_vfs_open_uri (class, uri, open_mode)
	SV *class
	GnomeVFSURI *uri
	GnomeVFSOpenMode open_mode
    PREINIT:
	GnomeVFSResult result;
	GnomeVFSHandle *handle;
    PPCODE:
	result = gnome_vfs_open_uri (&handle, uri, open_mode);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGnomeVFSResult (result)));
	PUSHs (sv_2mortal (handle_to_object (handle)));

##  GnomeVFSResult gnome_vfs_create (GnomeVFSHandle **handle, const gchar *text_uri, GnomeVFSOpenMode open_mode, gboolean exclusive, guint perm) 
void
gnome_vfs_create (class, text_uri, open_mode, exclusive, perm)
	SV *class
	const gchar *text_uri
	GnomeVFSOpenMode open_mode
	gboolean exclusive
	guint perm
    PREINIT:
	GnomeVFSResult result;
	GnomeVFSHandle *handle;
    PPCODE:
	result = gnome_vfs_create (&handle, text_uri, open_mode, exclusive, perm);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGnomeVFSResult (result)));
	PUSHs (sv_2mortal (handle_to_object (handle)));

##  GnomeVFSResult gnome_vfs_create_uri (GnomeVFSHandle **handle, GnomeVFSURI *uri, GnomeVFSOpenMode open_mode, gboolean exclusive, guint perm) 
GnomeVFSResult
gnome_vfs_create_uri (class, uri, open_mode, exclusive, perm)
	SV *class
	GnomeVFSURI *uri
	GnomeVFSOpenMode open_mode
	gboolean exclusive
	guint perm
    PREINIT:
	GnomeVFSResult result;
	GnomeVFSHandle *handle;
    PPCODE:
	result = gnome_vfs_create_uri (&handle, uri, open_mode, exclusive, perm);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGnomeVFSResult (result)));
	PUSHs (sv_2mortal (handle_to_object (handle)));

##  GnomeVFSResult gnome_vfs_unlink (const gchar *text_uri) 
GnomeVFSResult
gnome_vfs_unlink (class, text_uri)
	SV *class
	const gchar *text_uri
    C_ARGS:
	text_uri

##  GnomeVFSResult gnome_vfs_unlink_from_uri (GnomeVFSURI *uri) 
GnomeVFSResult
gnome_vfs_unlink_from_uri (class, uri)
	SV *class
	GnomeVFSURI *uri
    C_ARGS:
	uri

##  GnomeVFSResult gnome_vfs_move_uri (GnomeVFSURI *old_uri, GnomeVFSURI *new_uri, gboolean force_replace) 
GnomeVFSResult
gnome_vfs_move_uri (class, old_uri, new_uri, force_replace)
	SV *class
	GnomeVFSURI *old_uri
	GnomeVFSURI *new_uri
	gboolean force_replace
    C_ARGS:
	old_uri, new_uri, force_replace

##  GnomeVFSResult gnome_vfs_move (const gchar *old_text_uri, const gchar *new_text_uri, gboolean force_replace) 
GnomeVFSResult
gnome_vfs_move (class, old_text_uri, new_text_uri, force_replace)
	SV *class
	const gchar *old_text_uri
	const gchar *new_text_uri
	gboolean force_replace
    C_ARGS:
	old_text_uri, new_text_uri, force_replace

##  GnomeVFSResult gnome_vfs_check_same_fs_uris (GnomeVFSURI *source_uri, GnomeVFSURI *target_uri, gboolean *same_fs_return) 
void
gnome_vfs_check_same_fs_uris (class, source_uri, target_uri)
	SV *class
	GnomeVFSURI *source_uri
	GnomeVFSURI *target_uri
    PREINIT:
	GnomeVFSResult result;
	gboolean same_fs_return;
    PPCODE:
	result = gnome_vfs_check_same_fs_uris (source_uri, target_uri, &same_fs_return);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGnomeVFSResult (result)));
	PUSHs (sv_2mortal (newSVuv (same_fs_return)));

##  GnomeVFSResult gnome_vfs_check_same_fs (const gchar *source, const gchar *target, gboolean *same_fs_return) 
void
gnome_vfs_check_same_fs (class, source, target)
	SV *class
	const gchar *source
	const gchar *target
    PREINIT:
	GnomeVFSResult result;
	gboolean same_fs_return;
    PPCODE:
	result = gnome_vfs_check_same_fs (source, target, &same_fs_return);
	EXTEND (sp, 2);
	PUSHs (sv_2mortal (newSVGnomeVFSResult (result)));
	PUSHs (sv_2mortal (newSVuv (same_fs_return)));

##  GnomeVFSResult gnome_vfs_create_symbolic_link (GnomeVFSURI *uri, const gchar *target_reference) 
GnomeVFSResult
gnome_vfs_create_symbolic_link (class, uri, target_reference)
	SV *class
	GnomeVFSURI *uri
	const gchar *target_reference
    C_ARGS:
	uri, target_reference

MODULE = Gnome2::VFS::Ops	PACKAGE = Gnome2::VFS::Handle	PREFIX = gnome_vfs_

##  GnomeVFSResult gnome_vfs_close (GnomeVFSHandle *handle) 
GnomeVFSResult
gnome_vfs_close (handle)
	GnomeVFSHandle *handle

MODULE = Gnome2::VFS::Ops	PACKAGE = Gnome2::VFS::URI	PREFIX = gnome_vfs_uri_

##  gboolean gnome_vfs_uri_exists (GnomeVFSURI *uri) 
gboolean
gnome_vfs_uri_exists (uri)
	GnomeVFSURI *uri

###  GnomeVFSResult gnome_vfs_read (GnomeVFSHandle *handle, gpointer buffer, GnomeVFSFileSize bytes, GnomeVFSFileSize *bytes_read) 
#GnomeVFSResult
#gnome_vfs_read (handle, buffer, bytes, bytes_read)
#	GnomeVFSHandle *handle
#	gpointer buffer
#	GnomeVFSFileSize bytes
#	GnomeVFSFileSize *bytes_read
#
###  GnomeVFSResult gnome_vfs_write (GnomeVFSHandle *handle, gconstpointer buffer, GnomeVFSFileSize bytes, GnomeVFSFileSize *bytes_written) 
#GnomeVFSResult
#gnome_vfs_write (handle, buffer, bytes, bytes_written)
#	GnomeVFSHandle *handle
#	gconstpointer buffer
#	GnomeVFSFileSize bytes
#	GnomeVFSFileSize *bytes_written
#
###  GnomeVFSResult gnome_vfs_seek (GnomeVFSHandle *handle, GnomeVFSSeekPosition whence, GnomeVFSFileOffset offset) 
#GnomeVFSResult
#gnome_vfs_seek (handle, whence, offset)
#	GnomeVFSHandle *handle
#	GnomeVFSSeekPosition whence
#	GnomeVFSFileOffset offset
#
###  GnomeVFSResult gnome_vfs_tell (GnomeVFSHandle *handle, GnomeVFSFileSize *offset_return) 
#GnomeVFSResult
#gnome_vfs_tell (handle, offset_return)
#	GnomeVFSHandle *handle
#	GnomeVFSFileSize *offset_return
#
###  GnomeVFSResult gnome_vfs_get_file_info (const gchar *text_uri, GnomeVFSFileInfo *info, GnomeVFSFileInfoOptions options) 
#GnomeVFSResult
#gnome_vfs_get_file_info (text_uri, info, options)
#	const gchar *text_uri
#	GnomeVFSFileInfo *info
#	GnomeVFSFileInfoOptions options
#
###  GnomeVFSResult gnome_vfs_get_file_info_uri (GnomeVFSURI *uri, GnomeVFSFileInfo *info, GnomeVFSFileInfoOptions options) 
#GnomeVFSResult
#gnome_vfs_get_file_info_uri (uri, info, options)
#	GnomeVFSURI *uri
#	GnomeVFSFileInfo *info
#	GnomeVFSFileInfoOptions options
#
###  GnomeVFSResult gnome_vfs_get_file_info_from_handle (GnomeVFSHandle *handle, GnomeVFSFileInfo *info, GnomeVFSFileInfoOptions options) 
#GnomeVFSResult
#gnome_vfs_get_file_info_from_handle (handle, info, options)
#	GnomeVFSHandle *handle
#	GnomeVFSFileInfo *info
#	GnomeVFSFileInfoOptions options
#
###  GnomeVFSResult gnome_vfs_truncate (const gchar *text_uri, GnomeVFSFileSize length) 
#GnomeVFSResult
#gnome_vfs_truncate (text_uri, length)
#	const gchar *text_uri
#	GnomeVFSFileSize length
#
###  GnomeVFSResult gnome_vfs_truncate_uri (GnomeVFSURI *uri, GnomeVFSFileSize length) 
#GnomeVFSResult
#gnome_vfs_truncate_uri (uri, length)
#	GnomeVFSURI *uri
#	GnomeVFSFileSize length
#
###  GnomeVFSResult gnome_vfs_truncate_handle (GnomeVFSHandle *handle, GnomeVFSFileSize length) 
#GnomeVFSResult
#gnome_vfs_truncate_handle (handle, length)
#	GnomeVFSHandle *handle
#	GnomeVFSFileSize length
#
###  GnomeVFSResult gnome_vfs_make_directory_for_uri (GnomeVFSURI *uri, guint perm) 
#GnomeVFSResult
#gnome_vfs_make_directory_for_uri (uri, perm)
#	GnomeVFSURI *uri
#	guint perm
#
###  GnomeVFSResult gnome_vfs_make_directory (const gchar *text_uri, guint perm) 
#GnomeVFSResult
#gnome_vfs_make_directory (text_uri, perm)
#	const gchar *text_uri
#	guint perm
#
###  GnomeVFSResult gnome_vfs_remove_directory_from_uri (GnomeVFSURI *uri) 
#GnomeVFSResult
#gnome_vfs_remove_directory_from_uri (uri)
#	GnomeVFSURI *uri
#
###  GnomeVFSResult gnome_vfs_remove_directory (const gchar *text_uri) 
#GnomeVFSResult
#gnome_vfs_remove_directory (text_uri)
#	const gchar *text_uri
#
###  GnomeVFSResult gnome_vfs_set_file_info_uri (GnomeVFSURI *uri, GnomeVFSFileInfo *info, GnomeVFSSetFileInfoMask mask) 
#GnomeVFSResult
#gnome_vfs_set_file_info_uri (uri, info, mask)
#	GnomeVFSURI *uri
#	GnomeVFSFileInfo *info
#	GnomeVFSSetFileInfoMask mask
#
###  GnomeVFSResult gnome_vfs_set_file_info (const gchar *text_uri, GnomeVFSFileInfo *info, GnomeVFSSetFileInfoMask mask) 
#GnomeVFSResult
#gnome_vfs_set_file_info (text_uri, info, mask)
#	const gchar *text_uri
#	GnomeVFSFileInfo *info
#	GnomeVFSSetFileInfoMask mask
#
###  GnomeVFSResult gnome_vfs_monitor_add (GnomeVFSMonitorHandle **handle, const gchar *text_uri, GnomeVFSMonitorType monitor_type, GnomeVFSMonitorCallback callback, gpointer user_data) 
#GnomeVFSResult
#gnome_vfs_monitor_add (handle, text_uri, monitor_type, callback, user_data)
#	GnomeVFSMonitorHandle **handle
#	const gchar *text_uri
#	GnomeVFSMonitorType monitor_type
#	GnomeVFSMonitorCallback callback
#	gpointer user_data
#
###  GnomeVFSResult gnome_vfs_monitor_cancel (GnomeVFSMonitorHandle *handle) 
#GnomeVFSResult
#gnome_vfs_monitor_cancel (handle)
#	GnomeVFSMonitorHandle *handle
#
###  GnomeVFSResult gnome_vfs_file_control (GnomeVFSHandle *handle, const char *operation, gpointer operation_data) 
#GnomeVFSResult
#gnome_vfs_file_control (handle, operation, operation_data)
#	GnomeVFSHandle *handle
#	const char *operation
#	gpointer operation_data
