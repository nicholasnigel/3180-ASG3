use strict;
use warnings;

package Game;
use MannerDeckStudent; 
use Player;

#variable shared by the players within the game
our @card_stack = ();
#any self within this package means the game itself.
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
    my $self = shift @_;
    #deck should be shuffled evenly and distribute the cards evenly
    #but check player_num first of all
    my $number_of_players = scalar @{$self->{"players"}};
    
    # if >52 or 52%n !=0
    if (52 % $number_of_players) != 0 || $number_of_players >52) {
        #error message 
        return 1;
    }

    # print statement

    #print the names of player
    foreach my $name ($self->{"players"}) {
        print $name. "\n";
    }

    #shuffle deck
    $self->{"deck"}->shuffle();

    #distribute the cards to the players
    $self->{"deck"}->AveDealCards($number_of_players);

    #splice to remove a player 
    #if no more card, remove the player , winner is the last person 
    
    while(scalar @{$self->{"players"}} > 1 ) {
        # go through the player list and each should play
        foreach $player ($self->{"players"}) {
            #for each of the player in the list, then 
            

        }
    }

    
    
}

return 1;
