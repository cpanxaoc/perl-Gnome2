#
# $Header$
#

use 5.008;
use strict;
use ExtUtils::MakeMaker;
use Cwd;
use File::Spec;

# minimum required version of dependancies we need to build
our %build_reqs = (
	'perl-ExtUtils-Depends'   => '0.1',
	'perl-ExtUtils-PkgConfig' => '0.1',
	'perl-Glib'               => '1.00rc1',
	'perl-Gtk2'               => '1.00rc1',
	'Gnome'                   => '2.0.0',
	'Bonobo'                  => '2.0.0',
	'GnomeVFS'                => '2.0.0',
);

# minimum required version of dependancies we need to run
our %runtime_reqs = (
	'Gnome'	=> undef,
);

# Writing a fake Makefile ensures that CPAN will pick up the correct
# dependencies and install them.
unless (eval "use ExtUtils::Depends;"
           . "use ExtUtils::PkgConfig;"
	   . "use Gtk2::CodeGen;"
           # just seeing if Glib is available isn't enough, make sure
           # it's recent enough, too 
           . "use Glib '$build_reqs{'perl-Glib'}';"
           . "use Gtk2 '$build_reqs{'perl-Gtk2'}';"
           . "1") {
   warn "$@\n";
   WriteMakefile(
         PREREQ_FATAL => 1,
         PREREQ_PM    => {
            Glib::                => $build_reqs{'perl-Glib'},
            Gtk2::                => $build_reqs{'perl-Gtk2'},
            ExtUtils::Depends::   => $build_reqs{'perl-ExtUtils-Depends'},
            ExtUtils::PkgConfig:: => $build_reqs{'perl-ExtUtils-PkgConfig'},
         },
   );
   exit 1; # not reached
}

# now let's get started on the real work...
# in theory, getting what we need to build libgnomeui should 
# also get everything we need for libgnome.
my %gnome_pkgcfg = ExtUtils::PkgConfig->find ("libgnomeui-2.0 >= $build_reqs{Gnome}");
$runtime_reqs{Gnome} = $gnome_pkgcfg{modversion};

my %bonobo_pkgcfg = ExtUtils::PkgConfig->find("libbonoboui-2.0 >= $build_reqs{Bonobo}");

my %gnome_vfs_pkgcfg = ExtUtils::PkgConfig->find("gnome-vfs-2.0 >= $build_reqs{GnomeVFS}");

my %cfgs = (
	libgnomeui => \%gnome_pkgcfg,
	libbonoboui => \%bonobo_pkgcfg,
	gnome_vfs => \%gnome_vfs_pkgcfg,
);

mkdir 'build', 0777;

chomp(my $vfs_includes = `pkg-config --variable includedir gnome-vfs-2.0`);
my @vfs_headers = glob($vfs_includes . "/gnome-vfs-2.0/libgnomevfs/*.h");

system(q(glib-mkenums --fhead "#ifndef __GNOME2PERL_VFS_GTYPES_H__\n" ) .
                    q(--fhead "#define __GNOME2PERL_VFS_GTYPES_H__ 1\n\n" ) .
                    q(--fhead "#include <glib-object.h>\n\n" ) .
                    q(--fhead "G_BEGIN_DECLS\n\n" ) .
                    q(--eprod "#define GNOME_TYPE_@ENUMSHORT@ @enum_name@_get_type()\n" ) .
                    q(--eprod "GType @enum_name@_get_type (void);\n" ) .
                    q(--ftail "G_END_DECLS\n\n" ) .
                    q(--ftail "#endif /* __GNOME2PERL_VFS_GTYPES_H__ */\n" ) .
                    "@vfs_headers > build/gnome2perl-vfs-gtypes.h");

system(q(glib-mkenums --fhead "#include <libgnomevfs/gnome-vfs-types.h>\n" ) .
                    q(--fhead "#include <libgnomevfs/gnome-vfs-utils.h>\n" ) .
                    q(--fhead "#include <libgnomevfs/gnome-vfs-monitor.h>\n" ) .
                    q(--fhead "#include <libgnomevfs/gnome-vfs-mime-handlers.h>\n" ) .
                    q(--fhead "#include <libgnomevfs/gnome-vfs-directory.h>\n" ) .
                    q(--eprod "#define GNOME_TYPE_@ENUMSHORT@ @enum_name@_get_type()\n" ) .
                    q(--vhead "static const G@Type@Value _@enum_name@_values[] = {" ) .
                    q(--vprod "  { @VALUENAME@, \"@VALUENAME@\", \"@valuenick@\" }," ) .
                    q(--vtail "  { 0, NULL, NULL }\n};\n\n" ) .
                    q(--vtail "GType\n@enum_name@_get_type (void)\n{\n" ) .
                    q(--vtail "  static GType type = 0;\n\n" ) .
                    q(--vtail "  if (!type)\n" ) .
                    q(--vtail "    type = g_@type@_register_static (\"@EnumName@\", _@enum_name@_values);\n\n" ) .
                    q(--vtail "  return type;\n}\n\n" ) .
                    "@vfs_headers > xs/gnome2perl-vfs-gtypes.c");

# UGLY, UGLY, UGLY!
system("perl -pi -e 's/GNOME_TYPE_VFSURI_HIDE_OPTIONS/GNOME_TYPE_VFS_URI_HIDE_OPTIONS/g;
                     s/gnome_vfsuri_hide_options/gnome_vfs_uri_hide_options/g' build/gnome2perl-vfs-gtypes.h xs/gnome2perl-vfs-gtypes.c");

#
# autogeneration
#
Gtk2::CodeGen->parse_maps ('gnome2perl');
Gtk2::CodeGen->write_boot;

open VERSION, ">build/gnome2perl-version.h";
foreach my $pkg (keys %cfgs) {
	my $stem = uc $pkg;
	my @modversion = split /\./, $cfgs{$pkg}{modversion};
	print VERSION "#define $stem\_MAJOR_VERSION   ($modversion[0])\n";
	print VERSION "#define $stem\_MINOR_VERSION   ($modversion[1])\n";
	print VERSION "#define $stem\_MICRO_VERSION   ($modversion[2])\n";
	print VERSION
	     "#define $stem\_CHECK_VERSION(major,minor,micro) \\\n"
	   . "    ($stem\_MAJOR_VERSION > (major) || \\\n"
	   . "     ($stem\_MAJOR_VERSION == (major) && $stem\_MINOR_VERSION > (minor)) || \\\n"
	   . "     ($stem\_MAJOR_VERSION == (major) && $stem\_MINOR_VERSION == (minor) && \\\n"
	   . "      $stem\_MICRO_VERSION >= (micro)))\n";
}
close VERSION;


# now we're ready to start creating the makefile.
# we need to use ExtUtils::Depends to get relevant information out of
# the Glib extension, and to save config information for other modules which
# will chain from this one.

my $gnome2 = ExtUtils::Depends->new ('Gnome2', 'Gtk2', 'Glib');
$gnome2->set_inc ($gnome_pkgcfg{cflags} . " " . $bonobo_pkgcfg{cflags} . " " . $gnome_vfs_pkgcfg{cflags});
$gnome2->set_libs ($gnome_pkgcfg{libs} . " " . $bonobo_pkgcfg{libs} . " " . $gnome_vfs_pkgcfg{libs});
$gnome2->add_xs (<xs/*.xs>);
$gnome2->add_c ("xs/gnome2perl-vfs-gtypes.c");
$gnome2->add_pm ('Gnome2.pm' => '$(INST_LIBDIR)/Gnome2.pm');
$gnome2->add_typemaps (map {File::Spec->catfile(cwd(), $_)} 'build/gnome2perl.typemap', 'gnome2perl.typemap');
$gnome2->add_headers ('gnome2perl.h');

$gnome2->install (qw(gnome2perl.h
                     build/gnome2perl-autogen.h
                     build/gnome2perl-version.h));
$gnome2->save_config ('build/IFiles.pm');

WriteMakefile(
    NAME            => 'Gnome2',
    VERSION_FROM    => 'Gnome2.pm', # finds $VERSION
    ABSTRACT_FROM   => 'Gnome2.pm', # retrieve abstract from module
    XSPROTOARG      => '-noprototypes',
    $gnome2->get_makefile_vars,
);

#
# there's a bug in the MakeMaker output which results in .xs files in a
# subdirectory being turned into .o files in this dir.  the bug is a missing
# -o on the compiler command line.  this is a hackish fix for it.
#
package MY;
use Cwd;

sub const_cccmd {
	my $inherited = shift->SUPER::const_cccmd (@_);
	$inherited .= ' -o $@';
	$inherited;
}

sub postamble
{
	my @dirs = qw{rpms rpms/BUILD rpms/RPMS rpms/SOURCES
		      rpms/SPECS rpms/SRPMS};
	my $cwd = getcwd();

	my %subs = (
		'VERSION' => '$(VERSION)',
		'SOURCE' => '$(DISTNAME)-$(VERSION).tar.gz',
		'GNOME_RUN' => $runtime_reqs{'Gnome'},
		'GNOME' => $build_reqs{'Gnome'},
		'PERL_EXTUTILS_DEPENDS' => 
			$build_reqs{'perl-ExtUtils-Depends'},
		'PERL_EXTUTILS_PKGCONFIG' => 
			$build_reqs{'perl-ExtUtils-PkgConfig'},
		'PERL_GLIB' => $build_reqs{'perl-Glib'},
		'PERL_GTK' => $build_reqs{'perl-Gtk2'},
	);

	my $substitute = '$(PERL) -npe \''.join('; ', map {
			"s/\\\@$_\\\@/$subs{$_}/g";
		} keys %subs).'\'';

	"
realclean ::
	-\$(RM_RF) build perl-\$(DISTNAME).spec xs/gnome2perl-vfs-gtypes.c

rpms/:
	-mkdir @dirs

SUBSTITUTE=$substitute

perl-\$(DISTNAME).spec: perl-\$(DISTNAME).spec.in \$(VERSION_FROM) Makefile
	\$(SUBSTITUTE) \$< > \$@

dist-rpms: Makefile dist perl-\$(DISTNAME).spec rpms/
	cp \$(DISTNAME)-\$(VERSION).tar.gz rpms/SOURCES/
	rpmbuild -ba --define \"_topdir $cwd/rpms\" perl-\$(DISTNAME).spec
"
}
package MAIN;
