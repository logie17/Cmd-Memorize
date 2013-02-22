package Cmd::Memorize::View::Add;
use Moose;
use namespace::autoclean;
use Curses::UI;
with 'Cmd::Memorize::View::Wrapper';

has create_set_entry => (
    is => 'rw',
    lazy => 1,
    default => sub {
        $_[0]->window->add('mytextentry', 'TextEntry', -border => 1,  -text => "C",-x => 14, -y => 2, -label => 'foobar');    
    }
);

has create_set_entry_label => (
    is => 'rw',
    lazy => 1,
    default => sub {
        $_[0]->window->add('card_label', 'Label', -border => 1, -text => 'Front of Card');
    }
);

sub create_set {
    my $self = shift;
    my $text = $self->create_set_entry->get();
}

sub display {
    my $self = shift;
    my $window = $self->window;

}

__PACKAGE__->meta->make_immutable;
