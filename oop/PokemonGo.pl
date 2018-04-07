use strict;
use warnings;

package main;

use WaterTypePokemon;

my $squirtle = new WaterTypePokemon(80,30);
my $blastoise = new WaterTypePokemon(100,30);

print "originally squirtle hp is $squirtle->{'HP'} \n" ;
print "originally blastoise hp is $blastoise->{'HP'} \n";
my @players = ($squirtle, $blastoise);

our $target;
our $target_hp;

$squirtle->attack($blastoise);
$squirtle->attack($blastoise);



