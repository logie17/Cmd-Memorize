package Cmd::Memorize::View::Add;
use Moose;
use namespace::autoclean;
use Curses::UI;

sub display {
    my $cui = Curses::UI->new(-color_support=>1,-clear_on_exit=>1,-intellidraw=>1);
    $cui->dialog("We will add stuff");
    my $window = $cui->add('window', 'Window',-intellidraw=>1);
    my $message = $window->add(-text=>"Hello!",-intellidraw=>1);
    $window->focus();
    $cui->mainloop;
}


__PACKAGE__->meta->make_immutable;
