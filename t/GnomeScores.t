#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 1;
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

  my $scores = Gnome2::Scores -> new([qw(bla blub)],
                                     [1.3, 1.1127],
                                     [time(), time()],
                                     0);
  isa_ok($scores, "Gnome2::Scores");

  $scores -> set_logo_label("Losers:", "Sans 28",
                            Gtk2::Gdk::Color -> new(255, 0, 0));
  $scores -> set_logo_pixmap("yes.xpm");
  $scores -> set_logo_widget(Gtk2::Label -> new("Crawww"));
  $scores -> set_color(1, Gtk2::Gdk::Color -> new(0, 255, 0));
  $scores -> set_def_color(Gtk2::Gdk::Color -> new(0, 0, 255));
  $scores -> set_colors(Gtk2::Gdk::Color -> new(0, 0, 0));
  $scores -> set_logo_label_title("Blub");
  $scores -> set_current_player(1);

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
