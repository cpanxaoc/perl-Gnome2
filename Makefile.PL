#
# $Header$
#

use 5.008;
use ExtUtils::MakeMaker;
use Cwd;
use File::Spec;

# minimum required version of dependancies we need to build
our %build_reqs = (
	'perl-ExtUtils-Depends'   => '0.1',
	'perl-ExtUtils-PkgConfig' => '0.1',
	'perl-Glib'               => '1.00rc1',
	'perl-Gtk2'               => '1.00rc1',
	'Gnome'                  => '2.0.0.0',
);

# minimum required version of dependancies we need to run
our %runtime_reqs = (
	'Gnome'	=> undef,
);

# Writing a fake Makefile ensures that CPAN will pick up the correct
# dependencies and install them.
unless (eval "use ExtUtils::Depends;"
           . "use Glib::PkgConfig;"
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
%pkgcfg = Glib::PkgConfig->find ('libgnomeui-2.0');

$runtime_reqs{Gnome} = $pkgcfg{modversion};

mkdir 'build', 0777;

#
# autogeneration
#
Gtk2::CodeGen->parse_maps ('gnome2perl');
Gtk2::CodeGen->write_boot;

# now we're ready to start creating the makefile.
# we need to use ExtUtils::Depends to get relevant information out of
# the Glib extension, and to save config information for other modules which
# will chain from this one.

$gnome2 = ExtUtils::Depends->new ('Gnome2', 'Gtk2', 'Glib');
$gnome2->set_inc ($pkgcfg{cflags});
$gnome2->set_libs ($pkgcfg{libs});
$gnome2->add_xs (<xs/*.xs>);
$gnome2->add_pm ('Gnome2.pm' => '$(INST_LIBDIR)/Gnome2.pm');
my $cwd = cwd();
$gnome2->add_typemaps (map {File::Spec->catfile($cwd,$_)} 'build/gnome2perl.typemap', 'gnomeuiinfo.typemap');
$gnome2->add_headers ('gnome2perl.h');

$gnome2->install (qw(gnome2perl.h build/gnome2perl-autogen.h));
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
	-\$(RM_RF) build perl-\$(DISTNAME).spec

rpms/:
	-mkdir @dirs

SUBSTITUTE=$substitute

perl-\$(DISTNAME).spec: perl-\$(DISTNAME).spec.in \$(VERSION_FROM) Makefile
	\$(SUBSTITUTE) \$+ > \$@

dist-rpms: Makefile dist perl-\$(DISTNAME).spec rpms/
	cp \$(DISTNAME)-\$(VERSION).tar.gz rpms/SOURCES/
	rpmbuild -ba --define \"_topdir $cwd/rpms\" perl-\$(DISTNAME).spec
"
}
package MAIN;
