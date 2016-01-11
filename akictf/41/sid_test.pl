#!/usr/bin/env perl -w

use strict;
use warnings;
use feature qw/say/;

use Digest::SHA1 ();
use Data::Dumper;

my $sid = Digest::SHA1::sha1_hex(rand() . $$ . {} . time);

say $sid;
