#!/usr/bin/perl -w
use strict;
use Test::More tests => 4;
use Gnome2;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", 4)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", 4)
    unless (Gnome2::Client -> new() -> connected());

  ###############################################################################

  my $selection = Gnome2::IconSelection -> new();
  isa_ok($selection, "Gnome2::IconSelection");
  isa_ok($selection -> get_gil(), "Gnome2::IconList");
  isa_ok($selection -> get_box(), "Gtk2::VBox");

  $selection -> clear(1);

  $selection -> add_defaults();
  $selection -> add_directory("/usr/share/icons");

  $selection -> stop_loading();
  $selection -> show_icons();

  $selection -> select_icon("yes.xpm");
  is($selection -> get_icon(1), "/usr/share/pixmaps/yes.xpm");

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
