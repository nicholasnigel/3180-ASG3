
use warnings;
use strict;

package WaterTypePokemon;
sub new{

    my $class = shift @_;
    my $hp =shift @_;
    my $weight = shift @_;

    my $object = bless {"HP" => $hp, "weight" => $weight}, $class;
    
    return $object;
}

return 1;
