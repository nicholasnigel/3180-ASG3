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
    my $DeckObject = MannerDeckStudent->new();
    #initializing player list starting with empty
    my @player_list ={};
    my $object = bless{"deck" => $DeckObject, "players" => \@players_list }, $class;
    return $object;
}

sub set_players {
    my $self = shift @_;
    #$player_list to record the number of players
    my $player_list = shift \@_;
    my $player_number = scalar(@{$player_list});
    
}

sub getReturn {

}

sub showCards {
	
}

sub start_game {

}

return 1;
