package t::MusicBrainz::Server::Data::FreeDB;
use Test::Routine;
use Test::More;
use LWP::UserAgent::Mockable;

with 't::Context';

test "Correctly handle the 200 OK 'failed to process the response' error" => sub {
    my $test = shift;
    my $c    = $test->c;

    $ENV{LWP_UA_MOCK} = 'playback';
    $ENV{LWP_UA_MOCK_FILE} = 't/lwp-sessions/mbs-3622-freedb-import.lwp';

    my $entry = $c->model('FreeDB')->lookup('rock', '24116e15');
    is(scalar(@{ $entry->tracks }), 21);
    is($entry->title, 'Sunshine Live Vol. 39 CD 1');
    is($entry->artist, 'Sunshine Live Vol. 39 CD 1');

    LWP::UserAgent::Mockable->finished;
};

1;
