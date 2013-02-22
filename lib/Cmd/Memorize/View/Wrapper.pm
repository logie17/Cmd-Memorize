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

has window => (
    is => 'rw',
);

around display => sub {
    my ($next, $self) = (shift, shift);

    my $cui = $self->cui;
    my @menu = ({ -label => 'File', -submenu => [
                { -label => 'Create Set', -value => sub { $self->create_set } },
                { -label => 'Exit      ^Q', -value => sub { $self->exit_dialog } }
            ] 
        }
    );
    my $menu = $cui->add( 'menu','Menubar', -menu => \@menu, -fg  => "blue",);
    $self->window($cui->add('window', 'Window',-intellidraw=>1, -y => 1, -bfg => 'red'));
    $self->$next(@_);
    $cui->mainloop;
};

sub exit_dialog {
    my $self = shift;
    exit(0) if $self->cui->dialog( -message   => "Do you really want to quit?", -title     => "Are you sure???", -buttons   => ['yes', 'no'], );
}


1;
