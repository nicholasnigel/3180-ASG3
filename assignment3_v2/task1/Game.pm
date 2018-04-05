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
        $self->{"players"}[$index] = Player->new($_);
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
           if $cards[$i] == "J" {
               return scalar(@card_stack);
           }
       }
   }
}
    return 0;           #if there are no duplicte found, then that means, return 0 because nothing is supposed to be returned


#show cards on cardstack
sub showCards {
	#use the @cards_stack variable to show what are there
    my $class = shift @_;
    print join (" ", @cards);
    print "\n";

}

sub cardsToReturn { #this subroutine shall pass the list of cards from card stack to get cards , and delete it from the card stack

    my $self = shift @_;
    my $player = shift @_;
    my $i = 0;

    my $card_stack_num = scalar(@card_stack);

   while $i < $card_stack_num - 1 {
       while my $j = $i +1 < $card_stack_num {
           if $cards[$i] == $cards[$j] {
                my @to_return =  splice @card_stack , $i, $j-$i +1;
                $player->getCards(\@to_return);
           }
           if $cards[$i] == "J" {
               $player->getCards(\@card_stack);
               splice @card_stack;
           }
       }
   }
}
    
sub removePlayer {
    my $self = shift @_;
    my $player_to_remove = shift @_;
    my $num_of_player = scalar(@{$self->{"players"}});

    my $i = 0;
    while($i <$num_of_player ) {
        if $self->{"players"}[i] == $player_to_remove {
            splice @{$self->{"players"}}, $i, 1;        #if the player is the same, remove that player from the game
        }
    }
    
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

    print "there ${number_of_players} players in the game:\n"

    #print the names of player
    foreach my $name ($self->{"players"}) {
        print $name. "\n";
    }

    #shuffle deck
    $self->{"deck"}->shuffle();

    #distribute the cards to the players
    my @dis_cards = $self->{"deck"}->AveDealCards($number_of_players);  #the list of distributed cards

    for my $i (0..$number_of_players -1 ) {
        my @tempdeck = @{$dis_cards[$i]};
        $self->{"players"}[$i] -> getCards(\@tempdeck);                 # each player get the deck
    }

    #splice to remove a player 
    #if no more card, remove the player , winner is the last person 
    
    while(scalar @{$self->{"players"}} > 1 ) {
        # go through the player list and each should play
        foreach $player ($self->{"players"}) {
           
            #NOTE: push (@array, @list) will append @list to @array.
            my $dealtCard = $player->dealCards();    # each player deal a card 
            push(@card_stack, $dealtCard);    # push the dealt card to the game
            
            if( getReturn() > 0) {              #if the supposed return cards is greater than 0, means that there is a duplicate
                $self->cardsToReturn($player);
            }
        
            if $player->numCards() == 0 {       # if the number of card is 0, then 
                    #remove the player from the list of player
                $self->removePlayer($player)
            }        

        }
    }

    
    
}

return 1;
