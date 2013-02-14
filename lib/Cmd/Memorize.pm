package Cmd::Memorize;
use Moose;
use namespace::autoclean;
use Cmd::Memorize::View::Add;

with 'MooseX::Getopt';

has play  => ( is => 'rw', isa => 'Bool', default => 1 );
has add   => ( is => 'rw', isa => 'Bool', );

has add_view => ( is => 'rw', default => sub { Cmd::Memorize::View::Add->new }, lazy => 1 );

sub start {
    my $self = shift;

    $self->add ?  $self->_handle_add :
    $self->play ? $self->_handle_play : $self->_handle_error;
}

sub _handle_add {
    $_[0]->add_view->display;
}

sub _handle_play {
    # Todo implement
}

sub _handle_error {
    # Todo
}

__PACKAGE__->meta->make_immutable;
