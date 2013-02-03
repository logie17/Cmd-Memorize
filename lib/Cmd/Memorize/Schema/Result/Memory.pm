package Cmd::Memorize::Schema::Result::Memory;
use Cmd::Memorize::Schema::Candy;
use Moose;

primary_column id => { 
  data_type => 'int', 
  is_auto_increment => 1, 
  extra => { unsigned => 1 }, 
};

has_column hint => (
  data_type => 'text', 
);

has_column secret => (
  data_type => 'text', 
);

