#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 2;
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

  skip("GnomeThumbnail is new in 2.0.6", 2)
    unless (join("", Gnome2 -> get_version_info()) >= 206);

  ###############################################################################

  my $uri = "file:///usr/share/pixmaps/yes.xpm";
  my $file = "/usr/share/pixmaps/yes.xpm";
  my $mtime = (stat($file))[9];

  my $factory = Gnome2::ThumbnailFactory -> new("normal");
  isa_ok($factory, "Gnome2::ThumbnailFactory");

  $factory -> lookup($uri, $mtime);
  $factory -> has_valid_failed_thumbnail($uri, $mtime);
  $factory -> can_thumbnail($uri, "image/xpm", $mtime);

  my $thumbnail = $factory -> generate_thumbnail($uri, $mtime);
  isa_ok($thumbnail, "Gtk2::Gdk::Pixbuf");

  $factory -> save_thumbnail($thumbnail, $uri, $mtime);
  $factory -> create_failed_thumbnail($uri, $mtime);

  $thumbnail -> scale_down_pixbuf(5, 5);
  # XXX: $thumbnail -> has_uri($uri);
  # XXX: $thumbnail -> is_valid($uri, $mtime);
  $thumbnail -> md5($uri);
  $thumbnail -> path_for_uri($uri, "large");

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
