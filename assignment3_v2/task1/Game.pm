use strict;
use warnings;

package Game;
use MannerDeckStudent; 
use Player;

sub new {
	#Instantiate a variable deck with a Deck object
    #and array to record players

    $class = shift @_;
    #initialize new deck
    $DeckObject = Deck->new();
    #initializing player list starting with empty
    my @player_list =(' ');


}

sub set_players {
    $class = shift @_;

    #reference to the list
    $names_ref = shift \@_;

    $num_of_player = scalar(@{$names_ref});

    #check num_of_player if 52 % num == 0
    
}

sub getReturn {

}

sub showCards {
	
}

sub start_game {

}

return 1;
