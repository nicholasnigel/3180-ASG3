
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
sub Hi{
print "Hello\n";

}

sub attack {
    my $class = shift @_ ;
    my $target = shift @_ ;
    
    $target->{"HP"} -= 10;
}



return 1;
