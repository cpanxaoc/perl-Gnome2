/*
 * $Header$
 */

#include "gnome2perl.h"

MODULE = Gnome2::Program	PACKAGE = Gnome2::Program	PREFIX = gnome_program_

##  GnomeProgram * gnome_program_init (const char *app_id, const char *app_version, const GnomeModuleInfo *module_info, int argc, char **argv, const char *first_property_name, ...) 
GnomeProgram *
gnome_program_init (class, app_id, app_version, module_info, ...)
	SV * class
	const char * app_id
	const char * app_version
	SV * module_info
    PREINIT:
	AV * ARGV;
	SV * ARGV0;
	int argc, len, i;
	char ** argv;
	const GnomeModuleInfo * real_module_info = NULL;
    CODE:
	/* FIXME check validity of stack item count before doing 
	 *       anything else */

	/* let's see what the user passed for module_info */
	if (module_info == &PL_sv_undef) {
		/* go ahead and pass NULL.  you get libgnome initialized. */
	} else if (SvPOK (module_info)) {
		/* name of a module.  this is a limited-support hack. */
		char * modname = SvPV_nolen (module_info);
		if (strEQ ("libgnomeui", modname)) {
			real_module_info = LIBGNOMEUI_MODULE;
		} else if (strEQ ("libgnome", modname)) {
			real_module_info = LIBGNOME_MODULE;
		} else {
			croak ("you passed a string for module_info, but it wasn't one of 'libgnomeui' or 'libgnome'");
		}
	} else {
		real_module_info = SvGnomeModuleInfo (module_info);
	}

	/* we're good to go.  let's get a hold of @ARGV and $0 so we can
	 * synthesize the argv that gnome_program_init wants. */
	argv = NULL;
	ARGV = get_av ("ARGV", FALSE);
	ARGV0 = get_sv ("0", FALSE);

	/* construct the argv argument... we'll have to prepend @ARGV with $0
	 * to make it look real. */
	len = av_len (ARGV) + 1;
	argc = len + 1;
	argv = g_new0 (char*, argc);
	argv[0] = SvPV_nolen (ARGV0);
	/*warn ("argc = %d\n", argc);*/
	/*warn ("argv[0] = %s\n", argv[0]);*/
	for (i = 0 ; i < len ; i++) {
		SV ** sv = av_fetch (ARGV, i, FALSE);
		argv[i+1] = sv ? SvPV_nolen (*sv) : "";
		/*warn ("argv[%d] = %s\n", i+1, argv[i+1]);*/
	}
	/* note that we have *not* modifed @ARGV. */

	RETVAL = gnome_program_init (app_id, app_version, real_module_info,
	                             argc, argv, GNOME_PARAM_NONE);

	/* don't need this anymore -- note, do NOT destroy the strings
	 * themselves (they are still owned by their SVs) */
	g_free (argv);

	/* FIXME should get properties off the stack and handle them here! */
	warn ("FIXME -- need to implement getting object properties off the arg stack in Gnome2::Program::init");

    OUTPUT:
	RETVAL





##  GnomeProgram * gnome_program_get (void) 
GnomeProgram_ornull *
gnome_program_get (class)
	SV * class
    C_ARGS:
	

const char * gnome_program_get_human_readable_name (GnomeProgram * program);

const char* gnome_program_get_app_id        (GnomeProgram *program);

const char* gnome_program_get_app_version   (GnomeProgram *program);

##  gchar * gnome_program_locate_file (GnomeProgram *program, GnomeFileDomain domain, const gchar *file_name, gboolean only_if_exists, GSList **ret_locations) 
void
gnome_program_locate_file (program, domain, file_name, only_if_exists)
	GnomeProgram *program
	GnomeFileDomain domain
	const gchar *file_name
	gboolean only_if_exists
    PREINIT:
	gchar * path;
	GSList * ret_locations, * i;
    PPCODE:
	path = gnome_program_locate_file (program, domain, file_name,
	                                  only_if_exists, &ret_locations);
	XPUSHs (sv_2mortal (newSVpv (path, 0)));
	for (i = ret_locations; i != NULL ; i = i->next) {
		XPUSHs (sv_2mortal (newSVpv ((char*)(i->data), 0)));
		g_free (i->data);
	}
	g_slist_free (ret_locations);

##  void gnome_program_module_register (const GnomeModuleInfo *module_info) 
void
gnome_program_module_register (class, module_info)
	SV * class
	GnomeModuleInfo *module_info
    C_ARGS:
	module_info

##  gboolean gnome_program_module_registered (const GnomeModuleInfo *module_info) 
gboolean
gnome_program_module_registered (class, module_info)
	SV * class
	GnomeModuleInfo *module_info
    C_ARGS:
	module_info

##  const GnomeModuleInfo * gnome_program_module_load (const char * mod_name) 
GnomeModuleInfo *
gnome_program_module_load (class, mod_name)
	SV * class
	const char * mod_name
    CODE:
	/* just to keep the compiler from complaing about const */
	RETVAL = (GnomeModuleInfo*)gnome_program_module_load(mod_name);
    OUTPUT:
	RETVAL

