#!/usr/bin/perl -w
use strict;
use Gnome2;

use constant TESTS => 4;
use Test::More tests => TESTS;

# $Header$

###############################################################################

is(Gnome2::Util -> extension("blub.abw"), "abw");
is(Gnome2::Util -> prepend_user_home("blub.abw"), "$ENV{ HOME }/blub.abw");
is(Gnome2::Util -> home_file("blub.abw"), "$ENV{ HOME }/.gnome2/blub.abw");
ok(-e Gnome2::Util -> user_shell());
