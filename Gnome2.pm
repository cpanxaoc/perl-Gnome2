#
# $Header$
#

package Gnome2;

use 5.008;
use strict;
use warnings;

use Gtk2;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Gnome2 ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.20';

sub dl_load_flags { 0x01 }

bootstrap Gnome2 $VERSION;

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Gnome2 - Perl interface to the 2.x series of the Gnome libraries

=head1 SYNOPSIS

  use Gnome2;
  Gnome2::Program->init ($appname, $appversion);
  my $app = Gnome2::App->new ($appname);
  $app->show;
  Gtk2->main;

=head1 ABSTRACT

  Perl bindings to the 2.x series of the Gtk+ widget set.
  This module allows you to write graphical user interfaces in a perlish
  and object-oriented way, freeing you from the casting and memory 
  management in C, yet remaining very close in spirit to original API.

=head1 DESCRIPTION

The Gnome2 module allows a perl developer to use the Gnome libraries.
Find out more about Gnome+ at http://www.gnome.org.

To discuss gtk2-perl, ask questions and flame/praise the authors,
join gtk-perl-list@gnome.org at lists.gnome.org.

If you have a web site set up for your module, mention it here.

FIXME we have no other documentation, but we probably need it.

=head1 SEE ALSO

perl(1), Glib(1), Gtk2(1).

=head1 AUTHOR

muppet E<lt>scott@asofyet.orgE<gt>

If you want to own this project, please let me know.

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by muppet

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
