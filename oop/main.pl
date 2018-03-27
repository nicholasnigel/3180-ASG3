use strict;
use warnings;

package main;

use WaterTypePokemon;

my $squirtle = new WaterTypePokemon(80,30);
my $blastoise = new WaterTypePokemon(100,30);

$squirtle->attack($blastoise);

print $squirtle->{"HP"}. "\n"  ;
print $blastoise->{"HP"}. "\n" ;
$squirtle->Hi();
