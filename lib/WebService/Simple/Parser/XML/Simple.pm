# $Id$

package WebService::Simple::Parser::XML::Simple;
use strict;
use warnings;
use base qw(WebService::Simple::Parser);
use XML::Simple;

sub parse_response {
    my $self     = shift;
    my $response = shift;
    my %opt      = @_;
    return XMLin( $response->content, %opt );
}

1;

__END__

=head1 NAME 

WebService::Simple::Parser::XML::Simple - XML::Simple Adaptor For WebService::Simple::Parser

=head1 METHODS

=head2 parse_response

=cut
