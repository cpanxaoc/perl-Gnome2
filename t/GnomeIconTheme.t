#!/usr/bin/perl -w
use strict;
use Test::More tests => 7;
use Gnome2;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", 7)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", 7)
    unless (Gnome2::Client -> new() -> connected());

  ###############################################################################

  my $theme = Gnome2::IconTheme -> new();
  isa_ok($theme, "Gnome2::IconTheme");

  # XXX: $theme -> get_example_icon_name();

  my $factory = Gnome2::ThumbnailFactory -> new("normal");
  is_deeply([$theme -> lookup_sync(undef, "/usr/bin/perl", "", "none")],
            ["gnome-mime-application", []]);

  # XXX: $theme -> list_icons("gnome-unknown");

  is($theme -> has_icon("gnome-unknown"), 1);

  my ($file,
      $icon_data,
      $size) = $theme -> lookup_icon("gnome-starthere", 48);

  ok(-e $file);
  # XXX: $icon_data?
  like($size, qr/^\d+$/);

  $theme -> set_allow_svg(1);
  is($theme -> get_allow_svg(), 1);

  $theme -> rescan_if_needed();

  $theme -> set_search_path("/usr/share/icons");

  # XXX: these seem to do nothing.
  $theme -> append_search_path("/usr/share/pixmaps");
  $theme -> prepend_search_path("/usr/share/images");

  is($theme -> get_search_path(), "/usr/share/icons");

  $theme -> set_custom_theme("Crux");

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
