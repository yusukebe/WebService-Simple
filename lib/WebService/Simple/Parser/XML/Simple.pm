# $Id$

package WebService::Simple::Parser::XML::Simple;
use strict;
use warnings;
use base qw(WebService::Simple::Parser);
use XML::Simple;

sub parse_response
{
    return XMLin($_[1]->content);
}

1;

__END__

=head1 NAME 

WebService::Simple::Parser::XML::Simple - XML::Simple Adaptor For WebService::Simple::Parser

=cut