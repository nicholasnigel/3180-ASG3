use strict;
use warnings;

package main;

use WaterTypePokemon;

my $squirtle = new WaterTypePokemon(80,30);
my $blastoise = new WaterTypePokemon(100,30);

print "originally squirtle hp is $squirtle->{'HP'} \n" ;
print "originally blastoise hp is $blastoise->{'HP'} \n";
my @players = ($squirtle, $blastoise);


foreach my $pokemon (@players) {
    $pokemon->heal();
}
print "now squirtle hp is $squirtle->{'HP'}\n" ;
print "now blastoise hp is $blastoise->{'HP'}\n";
#proves that when use foreach, it the new symbol, it references to the component of the array itself


