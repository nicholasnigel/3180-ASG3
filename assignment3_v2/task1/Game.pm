use strict;
use warnings;

package Game;
use MannerDeckStudent; 
use Player;

#variable shared by the players within the game
our @card_stack = ();

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

    my $index = 0;
    #for each name in the player_list, initialize the 
    foreach(@{$player_list}) {
        $self->{"players"}[$i] = Player->new($_);
        $index++
    }
    return 1; # to show that creation is successful, error message should be in the start_game
}

#calculate how many will be returned to the player from the current stack
sub getReturn {
    #use the shared parameter card_stack
    my $class = shift @_;
    
    my $i = 0;

    my $card_stack_num = scalar(@card_stack);

   while $i < $card_stack_num - 1 {
       while my $j = $i +1 < $card_stack_num {
           if $cards[$i] == $cards[$j] {
               return $j - $i;
           }
       }
   }
}
#show cards on cardstack
sub showCards {
	#use the @cards_stack variable to show what are there
    my $class = shift @_;
    print join (" ", @cards);
    print "\n";

}

sub start_game {

}

return 1;
