use strict;
use warnings;

package Game;

use MannerDeckStudent; 
use Player;

return 1;
our @card_stack = ();   # cards_stack is to store the stack of dealt cards , shared by player

#any self within this package means the game itself.
sub new {
	#Instantiate a variable deck with a Deck object
    #and array to record players

    my $class = shift @_;
    #initialize new deck
    my $DeckObject = MannerDeckStudent->new();
    #initializing player list starting with empty
    my @players_list ={};
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
    my $j = 0;
    my $card_stack_num = scalar(@card_stack);
    print "$card_stack_num" . "\n";

    while ($i < $card_stack_num - 1) {
       while ( $j = $i +1 < $card_stack_num) {
           if ($card_stack[$i] eq $card_stack[$j]) {
               return $j - $i;
           }
           if ($card_stack[$i] eq "J") {
               return scalar(@card_stack);
           }
           $j++;
       }
    $i++;
   }    


    return 0;          #if there are no duplicte found, then that means, return 0 because nothing is supposed to be returned
}
    


#show cards on cardstack
sub showCards {
	#use the @card_stack variable to show what are there
    my $class = shift @_;
    print join (" ", @card_stack);
    print "\n";

}

sub cardsToReturn { #this subroutine shall pass the list of cards from card stack to get cards , and delete it from the card stack

    my $self = shift @_;
    my $player = shift @_;
    my $i = 0;

    my $card_stack_num = scalar(@card_stack);

   while ($i < $card_stack_num - 1) {
       while (my $j = $i +1 < $card_stack_num) {
           if ($card_stack[$i] == $card_stack[$j]) {
                my @to_return =  splice @card_stack , $i, $j-$i +1;
                $player->getCards(\@to_return);
           }
           if ($card_stack[$i] == "J") {
               $player->getCards(\@card_stack);
               splice @card_stack;
           }
           $j++;
       }
       $i++;
   }
}
    
sub removePlayer {
    my $self = shift @_;
    my $player_to_remove = shift @_;
    my $num_of_player = scalar(@{$self->{"players"}});

    my $i = 0;
    while($i <$num_of_player ) {
        if ($self->{"players"}[$i] == $player_to_remove) {
            splice @{$self->{"players"}}, $i, 1;        #if the player is the same, remove that player from the game
        }
        $i++;
    }
    
}



# sub routine that starts the game
sub start_game {            
    my $self = shift @_;
    
    my $number_of_players = scalar @{$self->{"players"}};   # check number of players
    
    
    if (((52 % $number_of_players)) != 0 || $number_of_players >52) {  # if 52 cant be divided by number of player, error
        print "Error: cards' number 52 can not be divided by players number $number_of_players!\n";     # error message 
        return 1;
    }

    print "there $number_of_players players in the game:\n";

    #print the names of player
    foreach my $player (@{$self->{"players"}}) {
        print $player->{"name"};
        print " ";
    }
    print "\n";
    
    print"\nGame Begin!!!\n";

    $self->{"deck"}->shuffle(); #shuffle deck

   
    my @dis_cards = $self->{"deck"}->AveDealCards($number_of_players);  #the list of distributed cards

    for my $i (0..$number_of_players -1 ) {
        my @tempdeck = @{$dis_cards[$i]};
        $self->{"players"}[$i] -> getCards(\@tempdeck);                 # each player get the deck
    }

    
    
    while($number_of_players > 1 ) {
        # go through the player list and each should play

        foreach my $player (@{$self->{"players"}}) {
            my $card_per_player = scalar(@{$player->{"cards"}});      #find the number of card the player has
            

            print "Player ". $player->{"name"}. " has " . $card_per_player . " cards before deal";   #print first prompt: player ___ has ___ cards before deal
            print "\n";
            print "=====Before player's deal=======\n\n";

            print "================================\n";
            

            my $dealtCard = $player->dealCards();    # each player deal a card 
            print $player->{"name"}. " ==> card " . $dealtCard. "\n";
            push(@card_stack, $dealtCard);    # push the dealt card to the game
           
            
            if( getReturn() > 0) {              #if the supposed return cards is greater than 0, means that there is a duplicate
                $self->cardsToReturn($player);
            }
            
            
            print "=====After player's deal=======\n";
            print @card_stack;
            print "\n";
            print "================================\n";
            my $card_per_player_afterdeal = scalar(@{$player->{"cards"}});
            print "Player ". $player->{"name"}. " has " . $card_per_player_afterdeal . " cards after deal\n\n";
            if ($player->numCards() == 0) {       # if the number of card is 0, then 

                $self->removePlayer($player);       #remove the player from the list of player
                $number_of_players-- ;
            }        

        }


    }

    
    
}


