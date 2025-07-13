use strict;
use Test::More ( tests => 6 );

use HTTP::Response;

my $flickr_api_key = $ENV{FLICKR_API_KEY};
BEGIN
{
    use_ok("WebService::Simple");
    use_ok("WebService::Simple::Parser::XML::Simple");
}

{
    my $service = WebService::Simple->new(
        base_url => "https://api.flickr.com/services/rest/",
        params   => {
            api_key => $flickr_api_key
        }
    );

    isa_ok( $service->response_parser, "WebService::Simple::Parser::XML::Simple");

    SKIP: {
        if (! $flickr_api_key ) {
            skip( "Please set FLICKR_API_KEY to enable this test", 2 );
        }
    
        my $response = $service->get( { method => "flickr.test.echo", name => "value" } );
        my $xml = $response->parse_response;
    
        isa_ok( $xml, 'HASH' );
        is_deeply(
            $xml,
            {
                'name' => 'value',
                'method' => 'flickr.test.echo',
                'api_key' => $flickr_api_key,
                'stat' => 'ok'
            }
        );
    }
}

{
    my $parser   = WebService::Simple::Parser::XML::Simple->new;
    my $response = HTTP::Response->new(undef, undef, undef, 'like.filename');

    eval {
        $parser->parse_response($response);
    };

    like($@, qr{\bsyntax error\b}, 'parse as string');
}
