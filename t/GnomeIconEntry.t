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

  my $entry = Gnome2::IconEntry -> new("sometimes", "I wish you were here");
  isa_ok($entry, "Gnome2::IconEntry");

  $entry -> set_pixmap_subdir($ENV{ HOME });

  $entry -> set_filename("blablablub");
  ok(not defined($entry -> get_filename()));

  # $entry -> set_history_id("always");
  $entry -> set_browse_dialog_title("Boring");

  ok(not defined($entry -> pick_dialog()));

  $entry -> set_max_saved(23)
    if (Gnome2 -> check_version(2, 3, 3));
}
