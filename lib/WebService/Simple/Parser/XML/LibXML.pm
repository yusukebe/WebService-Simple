package WebService::Simple::Parser::XML::LibXML;
use strict;
use warnings;
use base qw(WebService::Simple::Parser);
use XML::LibXML;

sub new
{
    my $class = shift;
    my $args  = shift || {};
    $args->{libxml} ||= XML::LibXML->new;
    $class->SUPER::new($args);
}

sub parse_response
{
    my $self = shift;
    $self->{libxml}->parse_string( $_[1]->content );
}

1;