package Cmd::Memorize;
use Moose;
use namespace::autoclean;

with 'MooseX::Getopt';

has play  => ( is => 'rw', isa => 'Bool', default => 1 );
has add   => ( is => 'rw', isa => 'Bool', );

sub start {
    my $self = shift;

    $self->add ?  $self->_handle_add :
    $self->play ? $self->_handle_play : $self->_handle_error;
}

sub _handle_add {
    # Todo implement
}

sub _handle_play {
    # Todo implement
}

sub _handle_error {
    # Todo
}

__PACKAGE__->meta->make_immutable;
