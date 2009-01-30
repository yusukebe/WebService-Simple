use strict;
use Test::More qw( no_plan );

BEGIN {
    use_ok("WebService::Simple");
}

{
    my $service = WebService::Simple->new(
        response_parser => 'XML::Feed',
        base_url        => "http://gdata.youtube.com/feeds/api/videos",
    );

    isa_ok( $service->response_parser,
        "WebService::Simple::Parser::XML::Feed" );

    my $response =
      $service->get( { q => "oasis" } );
    my $feed = $response->parse_response;
    isa_ok( $feed, 'XML::Feed::Atom');
}


