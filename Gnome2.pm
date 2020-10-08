# $Id$

package Gnome2;

use 5.008;
use strict;
use warnings;

use Gtk2;
use Gnome2::Canvas;
use Gnome2::VFS;

require DynaLoader;

our @ISA = qw(DynaLoader);

our $VERSION = '1.047';

sub import {
  my $self = shift();
  $self -> VERSION(@_);
}

sub dl_load_flags { $^O eq 'darwin' ? 0x00 : 0x01 }

Gnome2 -> bootstrap($VERSION);

1;
__END__

=head1 NAME

Gnome2 - Perl interface to the 2.x series of the GNOME libraries

=head1 SYNOPSIS

  use Gnome2;
  Gnome2::Program->init ($appname, $appversion);
  my $app = Gnome2::App->new ($appname);
  $app->show;
  Gtk2->main;

=head1 ABSTRACT

B<(DEPRECATED)> Perl bindings to the 2.x series of the GNOME libraries.  This
module allows you to interface with the libgnome and libgnomeui libraries to
create GNOME applications.

=head1 DESCRIPTION

B<NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE>

This module has been deprecated by the Gtk-Perl project.  This means that the
module will no longer be updated with security patches, bug fixes, or when
changes are made in the Perl ABI.  The Git repo for this module has been
archived (made read-only), it will no longer possible to submit new commits to
it.  You are more than welcome to ask about this module on the Gtk-Perl
mailing list, but our priorities going forward will be maintaining Gtk-Perl
modules that are supported and maintained upstream; this module is neither.

Since this module is licensed under the LGPL v2.1, you may also fork this
module, if you wish, but you will need to use a different name for it on CPAN,
and the Gtk-Perl team requests that you use your own resources (mailing list,
Git repos, bug trackers, etc.) to maintain your fork going forward.

=over

=item *

Perl URL: https://gitlab.gnome.org/GNOME/perl-gnome2

=item *

Upstream URL: https://gitlab.gnome.org/Archive/libgnome

=item *

Last upstream version: 2.32.1

=item *

Last upstream release date: 2011-01-31

=item *

Migration path for this module: No upstream replacement

=back

B<NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE>


Since this module tries to stick very closely to the C API, the documentation
found at

  http://developer.gnome.org/libgnome

and

  http://developer.gnome.org/libgnomeui

is the canonical reference.

In addition to that, there's also the automatically generated API
documentation: L<Gnome2::index>(3pm).

The mapping described in L<Gtk2::api>(3pm) also applies to this module.

To discuss this module, ask questions and flame/praise the authors, join
gtk-perl-list@gnome.org at lists.gnome.org.

=head1 MISSING METHODS

=over

=item gnome_app_fill_menu_with_data

=item gnome_app_fill_menu_custom

Use gnome_app_fill_menu instead.

=item gnome_app_fill_toolbar_with_data

=item gnome_app_fill_toolbar_custom

Use gnome_app_fill_toolbar instead.

=item gnome_app_create_menus_interp

=item gnome_app_create_menus_with_data

=item gnome_app_create_menus_custom

Use gnome_app_create_menus instead.

=item gnome_app_create_toolbar_interp

=item gnome_app_create_toolbar_with_data

=item gnome_app_create_toolbar_custom

Use gnome_app_create_toolbar instead.

=item gnome_app_insert_menus_custom

=item gnome_app_insert_menus_with_data

=item gnome_app_insert_menus_interp

Use gnome_app_insert_menus instead.

=back

=head1 RENAMED METHODS

=over

=item gnome_program_get

Gnome2::Program->get has been renamed to ->get_program to avoid a clash with
GObject->get.

=item gnome_popup_menu_attach

Gtk2::Menu->attach has been renamed to ->attach_to to avoid a clash with
gtk_menu_attach.

=item gnome_popup_menu_append

Gtk2::Menu->append has been renamed to ->append_from to avoid a clash with
gtk_menu_shell_append.

=back

=head1 DIFFERENT CALL SIGNATURES OR SEMANTICS

=over

=item gnome_client_set_restart_command

=item gnome_client_set_discard_command

=item gnome_client_set_resign_command

=item gnome_client_set_shutdown_command

=item gnome_client_set_clone_command

Instead of argc and argv you simply pass in a list.

=item gnome_program_init

Gnome2::Program->init automagically fills argc and argv so just omit these
parameters.

=back

=head1 SEE ALSO

L<perl>(1), L<Gnome2::index>(3pm), L<Glib>(3pm), L<Gtk2>(3pm),
L<Gtk2::api>(3pm).

=head1 AUTHOR

muppet E<lt>scott at asofyet dot orgE<gt> did the initial stuff.

Torsten Schoenfeld E<lt>kaffeetisch at gmx dot deE<gt> took over between 0.34
and 0.36, and implemented lots of tests and missing functionality, and
corrected several of muppet's mistakes.

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2003-2006, 2013 by the gtk2-perl team (see the file AUTHORS)

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Lesser General Public License as published by the Free
Software Foundation; either version 2.1 of the License, or (at your option) any
later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

See the LICENSE file in the top level of this distribution for the complete
license terms.

=cut
