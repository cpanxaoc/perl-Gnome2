/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::Sound	PACKAGE = Gnome2::Sound	PREFIX = gnome_sound_

##  int gnome_sound_connection_get (void) 
int
gnome_sound_connection_get (class)
	SV * class
    C_ARGS:
	

##  void gnome_sound_init(const char *hostname) 
void
gnome_sound_init (class, hostname="localhost")
	SV * class
	const char *hostname
    C_ARGS:
	hostname

##  void gnome_sound_shutdown(void) 
void
gnome_sound_shutdown (class)
	SV * class
    C_ARGS:
	

##  int gnome_sound_sample_load(const char *sample_name, const char *filename) 
int
gnome_sound_sample_load (class, sample_name, filename)
	SV * class
	const char *sample_name
	const char *filename
    C_ARGS:
	sample_name, filename

##  void gnome_sound_play (const char * filename) 
void
gnome_sound_play (class, filename)
	SV * class
	const char * filename
    C_ARGS:
	filename

