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

  my $link = Gnome2::HRef -> new("ftp://ftp.freenet.de/pub/", "Freenet");
  isa_ok($link, "Gnome2::HRef");

  $link -> set_url("bla://blub");
  is($link -> get_url(), "bla://blub");

  $link -> set_text("Hmm");
  is($link -> get_text(), "Hmm");

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
