/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::GConf	PACKAGE = Gnome2::GConf	PREFIX = gnome_gconf_

##  gchar *gnome_gconf_get_gnome_libs_settings_relative (const gchar *subkey) 
gchar *
gnome_gconf_get_gnome_libs_settings_relative (class, subkey)
	SV * class
	const gchar *subkey
    C_ARGS:
	subkey

##  gchar *gnome_gconf_get_app_settings_relative (GnomeProgram *program, const gchar *subkey) 
gchar *
gnome_gconf_get_app_settings_relative (class, program, subkey)
	SV * class
	GnomeProgram *program
	const gchar *subkey
    C_ARGS:
	program, subkey
