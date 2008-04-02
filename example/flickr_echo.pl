use strict;
use warnings;
use WebService::Simple;
use Cache::File;

my $api_key = "a1e16e8713317f660e405bb6e047734f";
my $cache   = Cache::File->new(
    cache_root      => '/tmp/mycache',
    default_expires => '30 min',
);

my $flickr = WebService::Simple->new(
    base_url => "http://api.flickr.com/services/rest/",
    cache    => $cache,
    param    => { api_key => $api_key, }
);

my $response =
  $flickr->get( { method => "flickr.test.echo", name => "value" } );
my $ref = $response->parse_xml;
print $ref->{name} . "\n";
