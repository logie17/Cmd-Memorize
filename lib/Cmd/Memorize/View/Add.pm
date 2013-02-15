package Cmd::Memorize::View::Add;
use Moose;
use namespace::autoclean;
use Curses::UI;
with 'Cmd::Memorize::View::Wrapper';

sub display {
    my $self = shift;
    my $window = shift; 

    my $editor = $window->add(
        'add_card', 'TextEditor',
        -vscrollbar => 1,
        -wrapping => 1
    );
    $editor->focus;
    my $text = $editor->get();
}

__PACKAGE__->meta->make_immutable;
