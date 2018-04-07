
use warnings;
use strict;

our $target;
our $target_hp;

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

sub printHP {
   print $target->{"weight"};
   print "\n";
   print $target_hp;
   print "\n";
}

sub attack {
    my $self = shift @_ ;
    local $target = shift @_ ;
    
    $target->{"HP"} -= 10;
    
    local $target_hp = $target->{"HP"};
    my $str = printHP();

    print "\n";
}

sub heal {
    my $self =shift @_;

    $self->{"HP"} += 10;

}


return 1;
