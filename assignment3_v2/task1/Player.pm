use strict;
use warnings;
 
package Player;
sub new {
    #instantiate the class and store the name into a variable
    my $class = shift @_;
    my $name = shift @_;
    my @card_person = ();
    my $object = bless {"name" => $name, "cards" => \@card_person }, $class;
    return object;
}
#suppose the parameter is a list of card reference to be put on the bottom of the deck
sub getCards {
    my $self = shift @_;
    my $card_to_take = shift @_;

    foreach(@$card_to_take) {
        push @{$self->{"cards"}}, $_;
    }

}

#take card from the top of the deck(1st list) and put it into the game
sub dealCards {

}

sub numCards {
}

return 1;