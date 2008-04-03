use strict;
use warnings;
use WebService::Simple;
use YAML;
use utf8;
binmode STDOUT, ":utf8";

my $api_key = "your_api_key";

my $flickr = WebService::Simple->new(
    base_url => "http://api.flickr.com/services/rest/",
    param    => { api_key => $api_key, }
);

my $response =
  $flickr->get( { method => "flickr.photos.search", text => "富士山" } );
print Dump $response->parse_xml;
