package WebService::Simple;

use warnings;
use strict;
use Carp;
use URI::Escape;
use LWP::UserAgent;
use WebService::Simple::Response;

our $VERSION = '0.03';

sub new {
    my $class = shift;
    my $opt = ref $_[0] eq 'HASH' ? shift: {@_};
    croak "paramater base_url is required" unless $opt->{base_url};
    my $self = bless {
	ua => LWP::UserAgent->new,
	%$opt,
    }, $class;
    $self;
}

sub get {
    my ($self, $request_param, $opt) = @_;
    my $url = $self->_make_url($request_param, $opt->{path});
    my $response = $self->_fetch_url($url);
    return $response;
}

sub _fetch_url{
    my ($self, $url) = @_;
    my $response;
    if(exists $self->{cache}){
	$response = $self->{cache}->thaw($url);
	if(defined $response){
	    return $response;
	}
    }
    $response = $self->{ua}->get($url);
    croak "can't get the request" unless $response->is_success;
    if(exists $self->{cache}) {
	$self->{cache}->freeze($url, $response);
    }
    return $response;
}

sub _make_url{
    my ($self, $request_param, $path) = @_;
    my $base_url = $self->{base_url};
    if($path){
	$path =~ s!^/+!! if $base_url =~ m{/$};
	$base_url = $base_url . $path;
    }
    my $url = $base_url =~ /\?$/ ? $base_url : $base_url . "?";
    my @params;
    push(@params, $self->_hashref_to_str($self->{param}));
    push(@params, $self->_hashref_to_str($request_param));
    my $str = join("&", @params);
    return $url . $str;
}

sub _hashref_to_str {
    my ($self, $ref) = @_;
    my @strs;
    foreach my $key ( keys %$ref ){
	my $value = $ref->{$key};
	utf8::decode($value) unless utf8::is_utf8($value);
	my $str = "$key=" . URI::Escape::uri_escape_utf8($value);
	push(@strs, $str);
    }
    return @strs;
}


1;
__END__

=head1 NAME

WebService::Simple - Simple interface to Web Services APIs

=head1 VERSION

This document describes WebService::Simple version 0.03

=head1 SYNOPSIS

    use WebService::Simple;

    my $flickr = WebService::Simple->new(
        base_url => "http://api.flickr.com/services/rest/",
        param    => { api_key => "your_api_key", }
    );
    my $response =
      $flickr->get( { method => "flickr.test.echo", name => "value" } );
    my $ref = $response->parse_xml( { forcearray => [], keyattr => [] } );
    print $ref->{name} . "\n";

=head1 DESCRIPTION

WebService::Simple provides you a simple interface to Web Services APIs

=head1 METHODS

=over 4

=item new(I<%args>)

    my $flickr = WebService::Simple->new(
        base_url => "http://api.flickr.com/services/rest/",
        param    => { api_key => "your_api_key", }
    );

Create and return a new WebService::Simple object.
"new" Method requires a base_url of Web Service API.

=item get(I<%args>)

    my $response =
      $flickr->get( { method => "flickr.test.echo", name => "value" } );

Get the WebService::Simple::Response object.

If you want to add a path to base URL, use an option parameter.

    my $lingr = WebService::Simple->new(
        base_url => "http://www.lingr.com/",
        param    => { api_key => "your_api_key", format => "xml" }
    );
    my $response = $lingr->get( {}, { path => "/api/session/create" } );

=back

=head1 CACHING

Cache the response of Web Service APIs by using Cache object.
Here's an example.

    my $cache = Cache::File->new(
        cache_root      => "/tmp/mycache",
        default_expires => "30 min",
    );

    my $flickr = WebService::Simple->new(
        base_url => "http://api.flickr.com/services/rest/",
        cache    => $cache,
        param    => { api_key => $api_key, }
    );


=head1 AUTHOR

Yusuke Wada  C<< <yusuke@kamawada.com> >>

=head1 COPYRIGHT AND LISENCE

Copyright (c) 2008 Yusuke Wada, All rights reserved.

This module is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.
See L<perlartistic>.

