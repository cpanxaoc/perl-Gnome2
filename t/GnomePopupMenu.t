#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 6;
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

  my $uiinfo = [
    { type => "item", label => "Item" },
    { type => "toggleitem", label => "Toggle" },
    {
      type => "subtree",
      label => "Radio Items",
      subtree => [
        {
          type => "radioitems",
          moreinfo => [
            {
              type => "item",
              label => "A"
            },
            {
              type => "item",
              label => "B",
              callback => sub { warn @_; }
            }
          ]
        }
      ]
    }
  ];

  my $additional_uiinfo = [
    { type => "item", label => "Really?" }
  ];

  #############################################################################

  my $popup = Gnome2::PopupMenu -> new($uiinfo);
  isa_ok($popup, "Gtk2::Menu");
  isa_ok($popup -> get_accel_group(), "Gtk2::AccelGroup");

  $popup = Gnome2::PopupMenu -> new_with_accelgroup($uiinfo);
  isa_ok($popup, "Gtk2::Menu");
  isa_ok($popup -> get_accel_group(), "Gtk2::AccelGroup");

  $popup = Gnome2::PopupMenu -> new_with_accelgroup($uiinfo, Gtk2::AccelGroup -> new());
  isa_ok($popup, "Gtk2::Menu");
  isa_ok($popup -> get_accel_group(), "Gtk2::AccelGroup");

  $popup -> append($additional_uiinfo);

  my $window = Gtk2::Window -> new("toplevel");
  my $button = Gtk2::Button -> new("BUH!");

  $window -> add($button);

  $popup -> attach($button);
  $popup -> attach($button, "blub");

  if (join("", Gtk2 -> get_version_info()) >= 220) {
    my $event = Gtk2::Gdk::Event -> new("button_press");

    $popup -> do_popup(
      sub {
        my ($menu) = @_;
        return 23, 42;
      },
      undef,
      $event,
      "bla",
      $button
    );
  }

  # FIXME: how to make it return?
  # $popup -> do_popup_modal(
  #   sub {
  #     my ($menu) = @_;
  #     return 23, 42;
  #   },
  #   undef,
  #   $event,
  #   "bla",
  #   $button
  # );

  $window -> add_popup_items($uiinfo);
  $window -> add_popup_items($uiinfo, "blab");
}
