#
# $Header$
#

use 5.008;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use Cwd;
use File::Spec;

# minimum required version of dependancies we need to build
our %build_reqs = (
	'perl-ExtUtils-Depends'   => '0.1',
	'perl-ExtUtils-PkgConfig' => '0.1',
	'perl-Glib'               => '1.00',
	'perl-Gtk2'               => '1.00',
	'Gnome'                   => '2.0.0',
	'Bonobo'                  => '2.0.0',
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
           . "use Glib::MakeHelper;" # for do_pod_files()
           # just seeing if Glib is available isn't enough, make sure
           # it's recent enough, too 
           . "use Glib atleast => '$build_reqs{'perl-Glib'}';"
           . "use Gtk2 atleast => '$build_reqs{'perl-Gtk2'}';"
           . "1") {
   warn "$@\n";
   WriteMakefile(
         PREREQ_FATAL => 1,
         PREREQ_PM    => {
            'Glib'                => $build_reqs{'perl-Glib'},
            'Gtk2'                => $build_reqs{'perl-Gtk2'},
            'ExtUtils::Depends'   => $build_reqs{'perl-ExtUtils-Depends'},
            'ExtUtils::PkgConfig' => $build_reqs{'perl-ExtUtils-PkgConfig'},
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

my %cfgs = (
	libgnomeui => \%gnome_pkgcfg,
	libbonoboui => \%bonobo_pkgcfg,
);

mkdir 'build', 0777;

our @xs_files = <xs/*.xs>;
our %pod_files = (
	'Gnome2.pm' => '$(INST_MAN3DIR)/Gnome2.$(MAN3EXT)',
	# we will be installing a whole slew of pod files, generated directly
	# from the xs source -- but to have them installed and manified
	# properly, we have to know their names at Makefile.PL time.
	#   This is a bit of a chicken and egg problem, and this solution
	# basically means that if you create a new package name in the xs
	# code, you'll need to re-run Makefile.PL.  you already need to
	# re-run to pick up new XS files, so that's not such a big deal. 
	Glib::MakeHelper->do_pod_files (@xs_files),
);
	
Glib::MakeHelper->do_pod_files (@xs_files),

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
$gnome2->set_inc ($gnome_pkgcfg{cflags} . " " . $bonobo_pkgcfg{cflags});
$gnome2->set_libs ($gnome_pkgcfg{libs} . " " . $bonobo_pkgcfg{libs});
$gnome2->add_xs (@xs_files);
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
    MAN3PODS        => \%pod_files,
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
	return Glib::MakeHelper->postamble_clean ()
	     . Glib::MakeHelper->postamble_docs (@main::xs_files)
	     . Glib::MakeHelper->postamble_rpms (
			'GNOME_RUN' => $runtime_reqs{'Gnome'},
			'GNOME' => $build_reqs{'Gnome'},
			'PERL_EXTUTILS_DEPENDS' => 
				$build_reqs{'perl-ExtUtils-Depends'},
			'PERL_EXTUTILS_PKGCONFIG' => 
				$build_reqs{'perl-ExtUtils-PkgConfig'},
			'PERL_GLIB' => $build_reqs{'perl-Glib'},
			'PERL_GTK' => $build_reqs{'perl-Gtk2'},
		);
}
package MAIN;
