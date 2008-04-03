use strict;
use warnings;
use WebService::Simple;

my $api_key  = "your_api_key";
my $room_id  = "hO4SmQWTdJ4"; # http://www.lingr.com/room/hO4SmQWTdJ4
my $nickname = "lingr.pl";
my $message  = $ARGV[0] || "Hello, World.";

my $lingr = WebService::Simple->new(
    base_url => 'http://www.lingr.com/',
    param    => { api_key => $api_key, format => 'xml' }
);

# create session, get session
my $response;
$response = $lingr->get( {}, { path => '/api/session/create' } );
my $session = $response->parse_xml->{session};

# enter the room, get ticket
$response = $lingr->get(
    {
        session  => $session,
        id       => $room_id,
        nickname => $nickname,
    },
    { path => '/api/room/enter' }
);
my $ticket = $response->parse_xml->{ticket};

# say 'Hello, World'
$response = $lingr->get(
    {
        session => $session,
        ticket  => $ticket,
        message => $message,
    },
    { path => '/api/room/say' }
);
my $status = $response->parse_xml->{status};

# destroy session
$lingr->get( { session => $session, }, { path => '/api/session/destroy' } );
