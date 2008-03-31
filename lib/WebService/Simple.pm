package WebService::Simple;

use warnings;
use strict;
use Carp;
use URI::Escape;
use LWP::UserAgent;
use WebService::Simple::Response;

our $VERSION = '0.01';

sub new {
    my ($class, $base_url, $param) = @_;
    croak "paramater base_url is required" unless $base_url;
    my $self = bless {
		      base_url => $base_url,
		      param => $param,
		  }, $class;
    $self;
}

sub get {
    my ($self, $request_param) = @_;
    my $url = $self->_make_url($request_param);
    my $ua = LWP::UserAgent->new;
    my $response = $ua->get($url);
    croak "can't get the request" unless $response->is_success;
    return $response;
}
sub _make_url{
    my ($self, $request_param) = @_;
    my $base_url = $self->{base_url};
    my $url = $base_url =~ /\?$/ ? $base_url : $base_url . "?";
    my @params;
    map {push(@params, "$_=" . $self->{param}->{$_})}  keys %{$self->{param}};
    map {push(@params, "$_=" . $request_param->{$_})}  keys %$request_param;
    my $str = join("&",@params);
    $url .= $str;
    return $url;
}

1;
__END__

=head1 NAME

WebService::Simple - Simple interface to any Web Service APIs

=head1 VERSION

This document describes WebService::Simple version 0.01


=head1 SYNOPSIS

    use WebService::Simple;

    my $flickr = WebService::Simple->new(
        "http://api.flickr.com/services/rest/",
        { api_key => "your_api_key", }
    );
    my $response =
      $flickr->get( { method => "flickr.test.echo", name => "value" } );
    my $ref = $response->parse_xml( { forcearray => [], keyattr => [] } );
    print $ref->{name} . "\n";

=head1 DESCRIPTION

WebService::Simple provides you a simple interface to any Web Servcie APIs

=head1 METHODS

=over 4

=item new(I<%args>)

    my $flickr = WebService::Simple->new(
        "http://api.flickr.com/services/rest/",
        { api_key => "your_api_key", }
    );

Create and return a new WebService::Simple object.
"new" Method requires an base_url of Web Service API.

=item get(I<%args>)

    my $response =
      $flickr->get( { method => "flickr.test.echo", name => "value" } );

Get the WebService::Simple::Response object.

=back

=head1 AUTHOR

Yusuke Wada  C<< <yusuke@kamawada.com> >>


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Yusuke Wada C<< <yusuke@kamawada.com> >>. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.

