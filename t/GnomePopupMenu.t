#!/usr/bin/perl -w
use strict;
use Test::More tests => 6;
use Gnome2;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", 6)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", 6)
    unless (Gnome2::Client -> new() -> connected());

  ###############################################################################

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
              label => "B"
            }
          ]
        }
      ]
    }
  ];

  my $additional_uiinfo = [
    { type => "item", label => "Really?" }
  ];

  ###############################################################################

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
  $popup -> attach($button, undef);

  my $event = Gtk2::Gdk::Event -> new("button_press");

  $popup -> do_popup(
    sub {
      my ($menu) = @_;
      return 23, 42;
    },
    undef,
    $event,
    undef,
    $button
  );

  # FIXME: how to make it return?
  # $popup -> do_popup_modal(
  #   sub {
  #     my ($menu) = @_;
  #     return 23, 42;
  #   },
  #   undef,
  #   $event,
  #   undef,
  #   $button
  # );

  $button -> add_popup_items($uiinfo);
  $button -> add_popup_items($uiinfo, undef);

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
