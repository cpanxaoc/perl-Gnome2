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

  my $entry = Gnome2::PixmapEntry -> new("schmih", "Schmah", 1);
  isa_ok($entry, "Gnome2::PixmapEntry");
  isa_ok($entry -> scrolled_window(), "Gtk2::ScrolledWindow");
  isa_ok($entry -> preview_widget(), "Gtk2::Widget");

  $entry -> set_pixmap_subdir("nautilus");
  $entry -> set_preview(1);
  $entry -> set_preview_size(23, 42);

  $entry -> get_filename();
}
