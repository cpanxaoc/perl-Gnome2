#
# $Header$
#

use 5.008;
use ExtUtils::MakeMaker;
use Cwd;
use ExtUtils::Depends;
use Glib::PkgConfig;
use Gtk2::CodeGen;

%pkgcfg = Glib::PkgConfig->find ('libgnomeui-2.0');

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
$gnome2->add_typemaps (map {cwd().'/'.$_} 'build/gnome2perl.typemap', 'gnomeuiinfo.typemap');
$gnome2->add_headers ('gnome2perl.h');

$gnome2->install (qw(gnome2perl.h build/gnome2perl-autogen.h));
$gnome2->save_config ('build/IFiles.pm');

WriteMakefile(
    NAME            => 'Gnome2',
    VERSION_FROM    => 'Gnome2.pm', # finds $VERSION
    PREREQ_PM       => {Gtk2 => 0.24}, # e.g., Module::Name => 1.1
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
sub const_cccmd {
	my $inherited = shift->SUPER::const_cccmd (@_);
	$inherited .= ' -o $@';
	$inherited;
}
package MAIN;
