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

sub parse_xml
{
    my $self = shift;
    $self->parse_response;
}

1;

__END__

=head1 NAME

Webservice::Simple::Response - Adds a parse_response() to HTTP::Response

=head1 AUTHOR

Yusuke Wada  C<< <yusuke@kamawada.com> >>

Daisuke Maki C<< <daisuke@endeworks.jp> >>

=head1 COPYRIGHT AND LICENSE

This module is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.
See L<perlartistic>.

=cut
