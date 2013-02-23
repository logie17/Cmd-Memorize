package Cmd::Memorize::View::Wrapper;

use Moose::Role;
requires 'display';

sub _build_screens {
    my $self = shift;
    my $screens = {};
    while (my ($id, $title) = each %{$self->screens} ) { 
        $screens->{$id} = $self->cui->add($id, 'Window', -title => $title, %{$self->window_args});
        $self->${\("_build_${id}")}($screens->{$id});
    }
    return $screens;
}

has cui => (
    is => 'rw',
    required => 1,
    default => sub {
        Curses::UI->new(-color_support => 1, -clear_on_exit => 1, -intellidraw => 1);
    }
);

has running_screens => (
    is => 'rw',
    isa => 'HashRef',
    lazy => 1,
    builder => '_build_screens', 
);

has window => (
    is => 'rw',
);

has window_args => (
    is => 'ro',
    isa => 'HashRef',
    default => sub { +{
        -border       => 1, 
        -titlereverse => 0, 
        -padtop       => 2, 
        -padbottom    => 3, 
        -ipad         => 1,
    }},
);


around display => sub {
    my ($next, $self) = (shift, shift);

    my $cui = $self->cui;
    my @menu = ({ -label => 'File', -submenu => [
                { -label => 'Create Set', -value => sub { $self->create_set } },
                { -label => 'Show Sets', -value => sub { $self->show_sets } },
                { -label => 'Exit      ^Q', -value => sub { $self->exit_dialog } }
            ] 
        }
    );


    my $menu = $cui->add( 'menu','Menubar', -menu => \@menu, -fg  => "blue",);
    $self->window($cui->add('window', 'Window',-intellidraw=>1, -y => 1, -bfg => 'red'));
    $self->$next(@_);

    for my $id ( keys %{$self->screens} ) {
        $self->meta->add_method($id => sub {
            my $self = shift;
            $self->running_screens->{$id}->focus;
        });
    }

    $cui->set_binding( sub{ exit }, "\cQ" );
    $cui->set_binding( sub{ shift()->root->focus('menu') }, "\cX" );
    

    $cui->mainloop;
};

sub exit_dialog {
    my $self = shift;
    exit(0) if $self->cui->dialog( -message   => "Do you really want to quit?", -title     => "Are you sure???", -buttons   => ['yes', 'no'], );
}


1;
