#!/usr/bin/perl -w
use strict;
use Gnome2;

use Test::More tests => 3;

# $Header$

###############################################################################

SKIP: {
  skip("the authentication stuff is new in 2.3.6", 3)
    unless (Gnome2 -> check_version(2, 3, 6));

  Gtk2 -> init();
  Gnome2::AuthenticationManager -> init();

  my $dialog = Gnome2::PasswordDialog -> new("Bla", "Bla!", "bla", "alb", 1);
  isa_ok($dialog, "Gnome2::PasswordDialog");

  $dialog -> set_username("urgs");
  $dialog -> set_password("urgs");
  $dialog -> set_readonly_username(0);
  # $dialog -> set_remember(0);
  # $dialog -> set_remember_label_text(0);

  is($dialog -> get_username(), "urgs");
  is($dialog -> get_password(), "urgs");
  # is($dialog -> get_remember(), 0);

  # $dialog -> run_and_block();
}
