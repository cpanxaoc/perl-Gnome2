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

  #############################################################################

  my $entry = Gnome2::FileEntry -> new("cookies", "Be Open!");
  isa_ok($entry, "Gnome2::FileEntry");
  isa_ok($entry -> gnome_entry(), "Gnome2::Entry");
  isa_ok($entry -> gtk_entry(), "Gtk2::Entry");

  $entry -> set_title("No Way!");
  $entry -> set_default_path($ENV{ HOME });

  $entry -> set_directory_entry(1);
  is($entry -> get_directory_entry(), 1);

  $entry -> set_filename(".");

  ok(-d $entry -> get_full_path(1));

  $entry -> set_modal(1);
  is($entry -> get_modal(), 1);
}
