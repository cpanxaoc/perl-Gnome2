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

  my $entry = Gnome2::PixmapEntry -> new("schmih", "Schmah", 1);
  isa_ok($entry, "Gnome2::PixmapEntry");
  isa_ok($entry -> scrolled_window(), "Gtk2::ScrolledWindow");
  isa_ok($entry -> preview_widget(), "Gtk2::Widget");

  $entry -> set_pixmap_subdir("nautilus");
  $entry -> set_preview(1);
  $entry -> set_preview_size(23, 42);

  $entry -> get_filename();

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}