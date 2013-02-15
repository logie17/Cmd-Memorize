package Cmd::Memorize::View::Add;
use Moose;
use namespace::autoclean;
use Curses::UI;

with 'Cmd::Memorize::View::Wrapper';

sub display {
    my $self = shift;
}


__PACKAGE__->meta->make_immutable;
