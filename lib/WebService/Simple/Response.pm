# $Id$

package WebService::Simple::Response;
use strict;
use warnings;
use base qw(HTTP::Response);

sub new_from_response
{
    # XXX hack. This probably should be changed...
    my $class = shift;
    my %args  = @_;
    my $self = bless $args{response}, $class;
    $self->{__parser} = $args{parser};
    return $self;
}

sub parse_response
{
    my $self = shift;
    return $self->{__parser}->parse_response($self);
}

1;

__END__

=head1 NAME

Webservice::Simple::Response - Adds a xml_parse() to HTTP::Response

=head1 VERSION

This document describes Webservice::Simple::Response version 0.0.1

=head1 METHODS

=over 4

=item parse_xml(I<%args>)

Parse a xml content with XML::Simple and return the Perl object.
You can tell XML::Simple parse options as parameters.

  my $ref = $response->parse_xml( { forcearray => [], keyattr => [] } );

=back

=head1 AUTHOR

Yusuke Wada  C<< <yusuke@kamawada.com> >>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2008 Yusuke Wada, All rights reserved.

This module is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.
See L<perlartistic>.
