#!/usr/bin/perl
use strict;
use Test::More;

BEGIN {
    use MusicBrainz::Server::Context;
    use MusicBrainz::Server::Test;
    my $c = MusicBrainz::Server::Test->create_test_context();
    MusicBrainz::Server::Test->prepare_test_database($c);
    MusicBrainz::Server::Test->prepare_test_server();
}

use Test::WWW::Mechanize::Catalyst;
my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'MusicBrainz::Server');

$mech->get_ok("/tracklist/1", 'fetch tracklist index page');
$mech->content_contains('Dancing Queen', 'track 1');
$mech->content_contains('/recording/123c079d-374e-4436-9448-da92dedef3ce', 'track 1');
$mech->content_contains('ABBA', 'track 1');
$mech->content_contains('/artist/a45c079d-374e-4436-9448-da92dedef3cf', 'track 1');
$mech->content_contains('2:03', 'track 1');

$mech->content_contains('Dancing Queen', 'track 2');
$mech->content_contains('/recording/123c079d-374e-4436-9448-da92dedef3ce', 'track 1');
$mech->content_contains('ABBA', 'track 1');
$mech->content_contains('/artist/a45c079d-374e-4436-9448-da92dedef3cf', 'track 1');
$mech->content_contains('2:03', 'track 1');

$mech->content_contains('/release/f34c079d-374e-4436-9448-da92dedef3ce', 'shows releases');
$mech->content_contains('Arrival', 'shows releases');
$mech->content_contains('1/2', 'release medium position');
$mech->content_contains('Warp Records', 'release label');
$mech->content_contains('ABC-123', 'release catno');
$mech->content_contains('ABC-123-X', 'release catno');
$mech->content_contains('GB', 'release country');
$mech->content_contains('2009-05-08', 'release date');

done_testing;
