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

  my $link = Gnome2::HRef -> new("ftp://ftp.freenet.de/pub/", "Freenet");
  isa_ok($link, "Gnome2::HRef");

  $link -> set_url("bla://blub");
  is($link -> get_url(), "bla://blub");

  $link -> set_text("Hmm");
  is($link -> get_text(), "Hmm");
}
