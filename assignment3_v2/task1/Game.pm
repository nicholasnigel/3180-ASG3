=begin comment
/*
 * CSCI3180 Principles of Programming Languages
 *
 * --- Declaration ---
 *
 * I declare that the assignment here submitted is original except for source
 * material explicitly acknowledged. I also acknowledge that I am aware of
 * University policy and regulations on honesty in academic work, and of the
 * disciplinary guidelines and procedures applicable to breaches of such policy
 * and regulations, as contained in the website
 * http://www.cuhk.edu.hk/policy/academichonesty/
 *
 * Assignment 3
 * Name : Nigel Nicholas
 * Student ID : 1155088791
 * Email Addr : nigel7@cse.cuhk.edu.hk
 */

=cut
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

    
    for ($i = 0 ; $i<$card_stack_num  ; $i++) {
        if($card_stack[$i] eq "J") {
            my $position = $i+1;

            if($i !=0){
            return $card_stack_num;     # if you have obtained Jack and it's not in the first element, then return all card stack
            }
            
    }
        for ($j = $i + 1; $j< $card_stack_num ; $j++) {

            if($card_stack[$i] eq $card_stack[$j]) {

                return ($j - $i +1);            # if you find same card, then return the range inclusively
            }

        }

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



   



    
sub removePlayer {
    my $self = shift @_;
    my $player_to_remove = shift @_;
    my $num_of_player = scalar(@{$self->{"players"}});

    my $i = 0;
    while($i <$num_of_player ) {
        if ($self->{"players"}[$i] eq $player_to_remove) {
            splice @{$self->{"players"}}, $i, 1;        #if the player is the same, remove that player from the game
            return 1;
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

    print "There $number_of_players players in the game:\n";

    #print the names of player
    foreach my $player (@{$self->{"players"}}) {
        print $player->{"name"};
        print " ";
    }
    print "\n";
    
    print"\nGame begin!!!\n\n";

    $self->{"deck"}->shuffle(); #shuffle deck

   
    my @dis_cards = $self->{"deck"}->AveDealCards($number_of_players);  #the list of distributed cards

    for my $i (0..$number_of_players -1 ) {
        my @tempdeck = @{$dis_cards[$i]};
        $self->{"players"}[$i] -> getCards(\@tempdeck);                 # each player get the deck
    }

    my $round = 0;
    
    while($number_of_players > 1 ) {
        # go through the player list and each should play
        my $i = 0;
        while( $i< $number_of_players) {
            
            my $player = $self->{"players"}->[$i];
            my $card_per_player = scalar(@{$player->{"cards"}});      #find the number of card the player has
            

            print "Player ". $player->{"name"}. " has " . $card_per_player . " cards before deal.";   #print first prompt: player ___ has ___ cards before deal
            print "\n";
            print "=====Before player's deal=======\n";
            print "@card_stack\n";

            print "================================\n";
            

            my $dealtCard = $player->dealCards();    # each player deal a card 
            print $player->{"name"}. " ==> card " . $dealtCard. "\n";
            push(@card_stack, $dealtCard);    # push the dealt card to the game
           
            

            if($self->getReturn() > 0 ) {              #if the supposed return cards is greater than 0, means that there is a duplicate
                $player->findCardToReturn(\@card_stack);
            }

            
            print "=====After player's deal=======\n";
            print "@card_stack";# printing content of card stack
            print "\n";
            print "================================\n";
            my $card_per_player_afterdeal = scalar(@{$player->{"cards"}});
            print "Player ". $player->{"name"}. " has " . $card_per_player_afterdeal . " cards after deal.\n";
            #print "Player ". $player->{"name"}. " has deck:\n";
            #print @{$player->{"cards"}};
            #print "\n";
            if ($player->numCards() == 0) {       # if the number of card is 0, then 
                print "Player ". $player->{"name"} . " has no cards, out!\n";
                $self->removePlayer($player);       #remove the player from the list of player
                $number_of_players-- ;
                $i-=1;
                
            }       
            my $remaining_player = scalar (@{$self->{"players"}});
            

            print "\n";

            if ( $remaining_player == 1) {
                last;
            }

            $i++;
        }
        $round++;

    }
    
    my $winner = $self->{"players"}->[0]->{"name"};
    print "Winner is $winner in game $round\n";
    
}


