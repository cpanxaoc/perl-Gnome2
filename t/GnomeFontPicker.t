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

  my $picker = Gnome2::FontPicker -> new();
  isa_ok($picker, "Gnome2::FontPicker");

  $picker -> set_title("Sociol Distortion For President!");
  is($picker -> get_title(), "Sociol Distortion For President!");

  $picker -> set_mode("font-info");
  is($picker -> get_mode(), "font-info");

  $picker -> fi_set_use_font_in_label(1, 14);
  $picker -> fi_set_show_size(1);

  $picker -> set_mode("user-widget");

  my $label = Gtk2::Label -> new("Really?");

  $picker -> uw_set_widget($label);
  is($picker -> uw_get_widget(), $label);

  $picker -> set_font_name("sans 14");
  is($picker -> get_font_name(), "sans 14");

  $picker -> set_preview_text("Brown foxes suck.");
  is($picker -> get_preview_text(), "Brown foxes suck.");

  ###############################################################################

  Glib::Idle -> add(sub {
    Gtk2 -> main_quit();
    return 0;
  });

  Gtk2 -> main();
}
