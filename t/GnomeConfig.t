#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 34;
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

  Gnome2::Config -> push_prefix("Test");

  #############################################################################

  Gnome2::Config -> set_string("/State/Shit", "Oh yes.");
  is(Gnome2::Config -> get_string("/State/Shit"), "Oh yes.");

  Gnome2::Config -> set_translated_string("/State/Shit", "Oh yes.");
  is(Gnome2::Config -> get_translated_string("/State/Shit"), "Oh yes.");

  is_deeply([Gnome2::Config -> get_string_with_default("/State/Whops=bla")], [1, "bla"]);
  is_deeply([Gnome2::Config -> get_string_with_default("/State/Shit")], [0, "Oh yes."]);

  is_deeply([Gnome2::Config -> get_translated_string_with_default("/State/Whops=bla")], [1, "bla"]);
  is_deeply([Gnome2::Config -> get_translated_string_with_default("/State/Shit")], [0, "Oh yes."]);

  Gnome2::Config -> set_int("/Geometry/Width", 1024);
  is(Gnome2::Config -> get_int("/Geometry/Width"), 1024);

  is_deeply([Gnome2::Config -> get_int_with_default("/Geometry/Whops=1600")], [1, 1600]);
  is_deeply([Gnome2::Config -> get_int_with_default("/Geometry/Width")], [0, 1024]);

  Gnome2::Config -> set_float("/Geometry/Ratio", 1.23);
  is(Gnome2::Config -> get_float("/Geometry/Ratio"), 1.23);

  is_deeply([Gnome2::Config -> get_float_with_default("/Geometry/Whops=0.5")], [1, 0.5]);
  is_deeply([Gnome2::Config -> get_float_with_default("/Geometry/Ratio")], [0, 1.23]);

  Gnome2::Config -> set_bool("/State/Hidden", 1);
  ok(Gnome2::Config -> get_bool("/State/Hidden"));

  is_deeply([Gnome2::Config -> get_bool_with_default("/State/Whops=0")], [1, 0]);
  is_deeply([Gnome2::Config -> get_bool_with_default("/State/Hidden")], [0, 1]);

  ok(Gnome2::Config -> has_section("/State"));
  ok(not Gnome2::Config -> has_section("/Whops"));

  # #############################################################################

  Gnome2::Config::Private -> set_string("/State/Shit", "Oh yes.");
  is(Gnome2::Config::Private -> get_string("/State/Shit"), "Oh yes.");

  Gnome2::Config::Private -> set_translated_string("/State/Shit", "Oh yes.");
  is(Gnome2::Config::Private -> get_translated_string("/State/Shit"), "Oh yes.");

  is_deeply([Gnome2::Config::Private -> get_string_with_default("/State/Whops=bla")], [1, "bla"]);
  is_deeply([Gnome2::Config::Private -> get_string_with_default("/State/Shit")], [0, "Oh yes."]);

  is_deeply([Gnome2::Config::Private -> get_translated_string_with_default("/State/Whops=bla")], [1, "bla"]);
  is_deeply([Gnome2::Config::Private -> get_translated_string_with_default("/State/Shit")], [0, "Oh yes."]);

  Gnome2::Config::Private -> set_int("/Geometry/Width", 1024);
  is(Gnome2::Config::Private -> get_int("/Geometry/Width"), 1024);

  is_deeply([Gnome2::Config::Private -> get_int_with_default("/Geometry/Whops=1600")], [1, 1600]);
  is_deeply([Gnome2::Config::Private -> get_int_with_default("/Geometry/Width")], [0, 1024]);

  Gnome2::Config::Private -> set_float("/Geometry/Ratio", 1.23);
  is(Gnome2::Config::Private -> get_float("/Geometry/Ratio"), 1.23);

  # is_deeply([Gnome2::Config::Private -> get_float_with_default("/Geometry/Whops=0.5")], [1, 0.5]);
  # is_deeply([Gnome2::Config::Private -> get_float_with_default("/Geometry/Ratio")], [0, 1.23]);

  Gnome2::Config::Private -> set_bool("/State/Hidden", 1);
  ok(Gnome2::Config::Private -> get_bool("/State/Hidden"));

  is_deeply([Gnome2::Config::Private -> get_bool_with_default("/State/Whops=0")], [1, 0]);
  is_deeply([Gnome2::Config::Private -> get_bool_with_default("/State/Hidden")], [0, 1]);

  ok(Gnome2::Config::Private -> has_section("/State"));
  ok(not Gnome2::Config::Private -> has_section("/Whops"));

  #############################################################################

  # ok(Gnome2::Config -> sync_file("Test"));
  # ok(Gnome2::Config::Private -> sync_file("Test"));

  Gnome2::Config -> clean_key("/Geometry/Ratio");
  Gnome2::Config::Private -> clean_file("/Geometry/Ratio");
  Gnome2::Config -> clean_section("/Geometry");
  Gnome2::Config::Private -> clean_section("/Geometry");
  Gnome2::Config -> clean_file("Test");
  Gnome2::Config::Private -> clean_file("Test");

  Gnome2::Config -> drop_file("Test");
  Gnome2::Config::Private -> drop_file("Test");

  #############################################################################

  Gnome2::Config -> pop_prefix();

  #############################################################################

  is(Gnome2::Config -> get_real_path("Test"), "$ENV{ HOME }/.gnome2/Test");
  is(Gnome2::Config::Private -> get_real_path("Test"), "$ENV{ HOME }/.gnome2_private/Test");
}