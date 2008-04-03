package WebService::Simple::Response;

use warnings;
use strict;
use Carp;
use XML::Simple;
our $VERSION = '0.01';

sub HTTP::Response::parse_xml {
    my ($self, $opt) = @_;
    my $xs = XML::Simple->new( %$opt );
    my $results;
    eval { $results = $xs->XMLin($self->content) };
    croak("can't parse xml") if ($@);
    return $results;
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


=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008 Yusuke Wada, All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.
