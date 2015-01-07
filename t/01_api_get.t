use strict;
use Test::More;
use WebService::Simple;

subtest 'no default param / get()' => sub
{
    my $ws = WebService::Simple->new(
        base_url => 'http://example.com/',
    );

    my $req;
    $ws->add_handler(request_send => sub {
        $req = shift;
        HTTP::Response->new(200, 'OK');
    });

    $ws->get();
    is($req->uri->as_string, 'http://example.com/', "no extra_path");
    
    $ws->get({ bar => 123 });
    is($req->uri->as_string, 'http://example.com/?bar=123', "no extra_path + args");
    
    $ws->get({ bar => 123 }, 'X-Test' => 'boo');
    is($req->uri->as_string, 'http://example.com/?bar=123', "no extra_path + args + header");
    is($req->header('X-Test'), 'boo', "no extra_path + args + header");

    $ws->get({}, 'X-Test' => 'boo');
    is($req->uri->as_string, 'http://example.com/', "empty args + header");
    is($req->header('X-Test'), 'boo', "empty args + header");

    $ws->get('foo');
    is($req->uri->as_string, 'http://example.com/foo', "extra_path");

    $ws->get('foo', { bar => 123 });
    is($req->uri->as_string, 'http://example.com/foo?bar=123', "extra_path + args");
    
    $ws->get('foo', { bar => 123 }, 'X-Test' => 'boo');
    is($req->uri->as_string, 'http://example.com/foo?bar=123', "extra_path + args + header");
    is($req->header('X-Test'), 'boo', "extra_path + args + header");
};


subtest 'with default param / get()' => sub
{
    my $ws = WebService::Simple->new(
        base_url => 'http://example.com/',
        param   =>  { aaa => 'zzz' },
    );

    my $req;
    $ws->add_handler(request_send => sub {
        $req = shift;
        HTTP::Response->new(200, 'OK');
    });

    $ws->get();
    ok($req->header('accept-encoding'));
    is($req->uri->as_string, 'http://example.com/?aaa=zzz', "no extra_path");
    
    $ws->get({ bar => 123 });
    is($req->uri->as_string, 'http://example.com/?bar=123&aaa=zzz', "no extra_path + args");
    
    $ws->get({ bar => 123 }, 'X-Test' => 'boo');
    is($req->uri->as_string, 'http://example.com/?bar=123&aaa=zzz', "no extra_path + args + header");
    is($req->header('X-Test'), 'boo', "no extra_path + args + header");

    $ws->get({}, 'X-Test' => 'boo');
    is($req->uri->as_string, 'http://example.com/?aaa=zzz', "empty args + header");
    is($req->header('X-Test'), 'boo', "empty args + header");

    $ws->get('foo');
    is($req->uri->as_string, 'http://example.com/foo?aaa=zzz', "extra_path");

    $ws->get('foo', { bar => 123 });
    is($req->uri->as_string, 'http://example.com/foo?bar=123&aaa=zzz', "extra_path + args");
    
    $ws->get('foo', { bar => 123 }, 'X-Test' => 'boo');
    is($req->uri->as_string, 'http://example.com/foo?bar=123&aaa=zzz', "extra_path + args + header");
    is($req->header('X-Test'), 'boo', "extra_path + args + header");
};

done_testing();
