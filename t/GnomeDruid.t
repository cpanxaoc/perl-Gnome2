#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 6;
use Test::More tests => TESTS;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", TESTS)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", TESTS)
    unless (Gnome2::Client -> new() -> connected());

  ###############################################################################

  my $druid = Gnome2::Druid -> new();
  isa_ok($druid, "Gnome2::Druid");

  $druid -> set_buttons_sensitive(1, 1, 1, 1);
  $druid -> set_show_finish(0);
  $druid -> set_show_help(1);

  my $dummy_page = Gnome2::DruidPage -> new();

  foreach (qw(back cancel finish prepare next)) {
    $dummy_page -> signal_connect($_ => sub { ok(1); return 1; });
  }

  $dummy_page -> back();
  $dummy_page -> cancel();
  $dummy_page -> finish();
  $dummy_page -> prepare();
  $dummy_page -> next();

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
