#!/usr/bin/perl -w
use strict;
use Test::More tests => 3;
use Gnome2;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", 3)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", 3)
    unless (Gnome2::Client -> new() -> connected());

  ###############################################################################

  my $entry = Gnome2::IconEntry -> new("sometimes", "I wish you were here");
  isa_ok($entry, "Gnome2::IconEntry");

  $entry -> set_pixmap_subdir($ENV{ HOME });

  $entry -> set_filename("blablablub");
  ok(not defined($entry -> get_filename()));

  # $entry -> set_history_id("always");
  $entry -> set_browse_dialog_title("Boring");

  ok(not defined($entry -> pick_dialog()));

  $entry -> set_max_saved(23)
      if (join("", Gnome2 -> get_version_info()) >= 233);

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
