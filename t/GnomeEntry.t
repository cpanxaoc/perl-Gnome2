#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 3;
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

  #############################################################################

  my $entry = Gnome2::Entry -> new();
  isa_ok($entry, "Gnome2::Entry");

  isa_ok($entry -> gtk_entry, "Gtk2::Entry");

  # this would make gconf create an entry in its db.
  # $entry -> set_history_id("urgs");
  # is($entry -> get_history_id(), "urgs");

  SKIP: {
    skip("set_max_saved is new in 2.3.3", 1)
      unless (Gnome2 -> check_version(2, 3, 3));

    $entry -> set_max_saved(23);
    is($entry -> get_max_saved(), 23);
  }

  $entry -> prepend_history(1, "blub");
  $entry -> append_history(0, "blab");
  $entry -> clear_history();
}
