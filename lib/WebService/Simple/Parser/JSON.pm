# $Id$

package WebService::Simple::Parser::JSON;
use strict;
use warnings;
use base qw(WebService::Simple::Parser);
use JSON 2.0;

sub new
{
    my $class = shift;
    my %args  = @_;

    my $json  = delete $args{json} || JSON->new;
    my $self  = $class->SUPER::new(%args);
    $self->{json} = $json;
    return $self;
}

sub parse_response
{
    my $self = shift;
    $self->{json}->decode( $_[0]->content );
}

1;

