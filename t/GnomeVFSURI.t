#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 26;
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

  Gnome2::VFS -> init();

  ok(Gnome2::VFS -> initialized());

  my $uri = Gnome2::VFS::URI -> new("http://www.freenet.de");
  isa_ok($uri, "Gnome2::VFS::URI");

  ok($uri -> equal(Gnome2::VFS::URI -> new("http://www.freenet.de")));
  ok($uri -> is_parent(Gnome2::VFS::URI -> new("http://www.freenet.de/tmp/argh.html"), 1));

  is($uri -> to_string(qw(toplevel_method)), "www.freenet.de");
  is($uri -> resolve_relative("bla.html") -> to_string(), "http://www.freenet.de/bla.html");
  is($uri -> append_string("ble.html") -> to_string(), "http://www.freenet.de/ble.html");
  is($uri -> append_path("bli.html") -> to_string(), "http://www.freenet.de/bli.html");
  is($uri -> append_file_name("blo.html") -> to_string(), "http://www.freenet.de/blo.html");
  ok(not $uri -> is_local());

  $uri = Gnome2::VFS::URI -> new('ftp://bla:bla@ftp.freenet.de:21/pub');
  is($uri -> get_host_name(), "ftp.freenet.de");
  is($uri -> get_scheme(), "ftp");
  is($uri -> get_host_port(), 21);
  is($uri -> get_user_name(), "bla");
  is($uri -> get_password(), "bla");

  $uri = Gnome2::VFS::URI -> new("ftp://ftp.gna.org");
  $uri -> set_host_name("ftp.gnu.org");
  $uri -> set_host_port(21);
  $uri -> set_user_name("blub");
  $uri -> set_password("blub");
  is($uri -> get_host_name(), "ftp.gnu.org");
  is($uri -> get_scheme(), "ftp");
  is($uri -> get_host_port(), 21);
  is($uri -> get_user_name(), "blub");
  is($uri -> get_password(), "blub");

  $uri = Gnome2::VFS::URI -> new("/usr/bin/perl");

  ok($uri -> exists());
  is($uri -> get_path(), "/usr/bin/perl");
  # XXX: $uri -> get_fragment_identifier();

  is($uri -> extract_dirname(), "/usr/bin");
  is($uri -> extract_short_name(), "perl");
  is($uri -> extract_short_path_name(), "perl");

  # XXX: Gnome2::VFS::URI -> list_parse("/usr/bin/python\n/usr/bin/curl");

  is(Gnome2::VFS::URI -> make_full_from_relative("/usr/bin/", "perl"), "/usr/bin/perl");

  Gnome2::VFS -> shutdown();
}
