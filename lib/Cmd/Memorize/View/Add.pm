package Cmd::Memorize::View::Add;
use Moose;
use namespace::autoclean;
use Curses::UI;
use Module::Pluggable search_path => ['Cmd::Memorize::View::Add'], instantiate => 'new', sub_name => 'controllers';
with 'Cmd::Memorize::View::Wrapper';

has screens => (
    is => 'rw',
    isa => 'HashRef',
    default => sub { [ qw(ShowSets CreateSets) ] },
);

sub display {
    my $self = shift;
    my $window = $self->window;
}

1;
