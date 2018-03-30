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
    @player_list =(' ');

    
}

sub set_players {

}

sub getReturn {

}

sub showCards {
	
}

sub start_game {

}

return 1;
