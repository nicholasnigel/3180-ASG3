use strict;
use warnings;
 
package Player;
sub new {
    #instantiate the class and store the name into a variable
    my $class = shift @_;
    my $name = shift @_;

    my $object = bless {"name" => $name}, $class;
    return object;
}

sub getCards {
    
}

sub dealCards {
}

sub numCards {
}

return 1;