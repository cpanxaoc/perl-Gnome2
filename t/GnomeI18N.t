#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 2;
use Test::More tests => TESTS;

# $Header$

###############################################################################

ok(Gnome2::I18N -> get_language_list());
ok(Gnome2::I18N -> get_language_list("LC_MESSAGES"));

Gnome2::I18N -> push_c_numeric_locale();
Gnome2::I18N -> pop_c_numeric_locale();

###############################################################################

#Glib::Idle -> add(sub {
#  Gtk2 -> main_quit();
#  return 0;
#});
#
#Gtk2 -> main();
