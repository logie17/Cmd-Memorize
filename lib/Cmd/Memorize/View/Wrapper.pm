package Cmd::Memorize::View::Wrapper;

use Moose::Role;
requires 'display';

has cui => (
    is => 'rw',
    required => 1,
    default => sub {
        Curses::UI->new(-color_support => 1, -clear_on_exit => 1, -intellidraw => 1);
    }
);

around display => sub {
    my ($next, $self) = (shift, shift);

    my $cui = $self->cui;
    my @menu = (
      { -label => 'File', -submenu => [ { -label => 'Exit      ^Q', -value => sub { $self->exit_dialog }  } ] }
    );
    my $menu = $cui->add( 'menu','Menubar', -menu => \@menu, -fg  => "blue",);
    my $window = $cui->add('window', 'Window',-intellidraw=>1, -y => 1, -bfg => 'red');

    $self->next(@_);

    $window->focus();
    $cui->mainloop;
};

sub exit_dialog {
    my $self = shift;
    my $return = $self->cui->dialog( -message   => "Do you really want to quit?", -title     => "Are you sure???", -buttons   => ['yes', 'no'], );
    exit(0) if $return;
}


1;
