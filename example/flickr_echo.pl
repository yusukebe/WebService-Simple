use strict;
use warnings;
use WebService::Simple;

my $api_key = "your_api_key";
my $flickr  = WebService::Simple->new( "http://api.flickr.com/services/rest/",
    { api_key => $api_key, } );
my $response =
  $flickr->get( { method => "flickr.test.echo", name => "value" } );
my $ref = $response->parse_xml;
print $ref->{name} . "\n";
