use strict;
use warnings;

package Game;
use MannerDeckStudent; 
use Player;

sub new {
	#Instantiate a variable deck with a Deck object
    #and array to record players

    my $class = shift @_;
    #initialize new deck
    my $DeckObject = Deck->new();
    #initializing player list starting with empty
    my @player_list ={};
    my $object = bless{"deck" => $DeckObject, "players" => \@players_list }, $class;
    return $object;
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
