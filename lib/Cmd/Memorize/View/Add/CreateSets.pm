package Cmd::Memorize::View::Add;
use Moose;
use namespace::autoclean;
use Curses::UI;

sub build {
    my ($self, $window, $controller) = @_;
    $window->add(
        undef, 
        'Buttonbox',
        -y => 7,    
        -buttons => [
            { 
                -label => "< Create Set>",
                -onpress => sub {
                    my $button = shift;
                    my $set = $button->root->question(
                        -question => "What would you like the hint or the front of the card to say?",
                        -title    => 'Add Set Front',
                    );
                    if ($set) {
                        $button->root->dialog("Ok, adding this set: $set");
                        $controller->save($set);
                    }
                    else {
                        $button->root->dialog("Ok I guess not");
                    }
                } 
            },
        ],
    );

    $window->add(
        undef, 'Listbox',
        -y          => 8,
        -padbottom  => 2,
        -values     => [],
        -labels     => {},
        -width      => 20,
        -border     => 1,
        -title      => 'Listbox',
        -vscrollbar => 1,
        -onchange   => sub { $self->listbox_callback(@_) },
    );
}

sub listbox_callback {
    my $listbox = shift;
    my $label = $listbox->parent->getobj('listboxlabel');
    my @sel = $listbox->get;
    @sel = ('<none>') unless @sel;
    my $sel = "selected: " . join (", ", @sel);
    $label->text($listbox->title . " $sel");
}

