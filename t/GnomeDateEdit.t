#!/usr/bin/perl -w
use strict;
use Test::More tests => 5;
use Gnome2;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", 5)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", 5)
    unless (Gnome2::Client -> new() -> connected());

  ###############################################################################

  my $edit = Gnome2::DateEdit -> new(time(), 1, 1);
  isa_ok($edit, "Gnome2::DateEdit");

  $edit = Gnome2::DateEdit -> new_flags(0, [qw(show_time
                                               24_hr
                                               week_starts_on_monday)]);
  isa_ok($edit, "Gnome2::DateEdit");

  $edit -> set_time(time());
  like($edit -> get_time(), qr/^\d+$/);
  like($edit -> get_initial_time(), qr/^\d+$/);

  $edit -> set_popup_range(6, 12);

  $edit -> set_flags([qw(show_time 24_hr)]);
  # XXX: is_deeply([$edit -> get_flags()], [qw(show_time 24_hr)]);
  is($edit -> get_flags(), 3);

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
