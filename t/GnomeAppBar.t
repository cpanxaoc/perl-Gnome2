#!/usr/bin/perl -w
use strict;
use Test::More tests => 8;
use Gnome2;

# $Header$

###############################################################################

SKIP: {
  skip("You don't appear to have the GNOME session manager running.", 8)
    unless (-d "$ENV{ HOME }/.gconfd" &&
            -d "$ENV{ HOME }/.gnome2");

  my $application = Gnome2::Program -> init("Test", "0.1");

  skip("Couldn't connect to the session manager.", 8)
    unless (Gnome2::Client -> new() -> connected());

  #############################################################################

  my $app_bar = Gnome2::AppBar -> new(1, 1, "always");
  isa_ok($app_bar, "Gnome2::AppBar");

  $app_bar -> set_default("-");

  $app_bar -> set_status("BLA!");
  isa_ok($app_bar -> get_status(), "Gtk2::Entry");
  is($app_bar -> get_status() -> get_text(), "BLA!");

  $app_bar -> clear_stack();
  is($app_bar -> get_status() -> get_text(), "-");

  $app_bar -> push("BLUB!");
  is($app_bar -> get_status() -> get_text(), "BLUB!");

  $app_bar -> pop();
  is($app_bar -> get_status() -> get_text(), "-");

  $app_bar -> set_progress_percentage(0.23);

  isa_ok($app_bar -> get_progress(), "Gtk2::ProgressBar");

  $app_bar -> refresh();

  $app_bar -> set_prompt("Hmm?", 0);
  is($app_bar -> get_response(), "");
  $app_bar -> clear_prompt();

  #############################################################################

  Glib::Idle -> add(sub {
                      Gtk2 -> main_quit();
                      return 0;
                    });

  Gtk2 -> main();
}
