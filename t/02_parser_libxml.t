use strict;
use Test::More;

BEGIN
{
    eval { require XML::LibXML };
    if ($@) {
        plan(skip_all => "XML::LibXML not installed");
    } else {
        plan(tests => 2);
    }
    use_ok("WebService::Simple");
}

{
    my $service = WebService::Simple->new(
        base_url => "http://example.com/hoge",
        response_parser => "XML::LibXML"
    );
    isa_ok( $service->response_parser, "WebService::Simple::Parser::XML::LibXML");
}