#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 9;
use Test::More tests => TESTS;

Gnome2::VFS -> init();

# $Header$

###############################################################################

SKIP: {
  our $application;
  do "t/TestBoilerplate";

  skip("GnomeIconTheme is new in 2.0.6", TESTS)
    unless (Gnome2 -> check_version(2, 0, 6));

  #############################################################################

  my $theme = Gnome2::IconTheme -> new();
  isa_ok($theme, "Gnome2::IconTheme");

  # FIXME: $theme -> get_example_icon_name();

  my @icon = $theme -> lookup_sync(undef, "/usr/bin/perl", undef, "none");
  ok(scalar(@icon) == 2 and defined($icon[0]));

  my ($result, $info) = Gnome2::VFS -> get_file_info("/usr/bin/perl", "get-mime-type");

  @icon = $theme -> lookup(undef,
                           "/usr/bin/perl",
                           undef,
                           $info,
                           "application/x-executable-binary",
                           "none");
  ok(scalar(@icon) == 2 and defined($icon[0]));

  ok($theme -> list_icons());

  is($theme -> has_icon("gnome-unknown"), 1);

  my ($file,
      $icon_data,
      $size) = $theme -> lookup_icon("gnome-starthere", 48);

  ok(-e $file);
  # FIXME: $icon_data?
  like($size, qr/^\d+$/);

  $theme -> set_allow_svg(1);
  is($theme -> get_allow_svg(), 1);

  $theme -> rescan_if_needed();

  $theme -> set_search_path("/usr/share/icons");

  # FIXME: these seem to do nothing.
  $theme -> append_search_path("/usr/share/pixmaps");
  $theme -> prepend_search_path("/usr/share/images");

  is($theme -> get_search_path(), "/usr/share/icons");

  $theme -> set_custom_theme("Crux");
}

###############################################################################

Gnome2::VFS -> shutdown();
