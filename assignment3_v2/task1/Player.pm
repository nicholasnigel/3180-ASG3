use strict;
use warnings;
 
package Player;
sub new {
    #instantiate the class and store the name into a variable
    my $class = shift @_;
    my $name = shift @_;
    my @card_person = ();
    my $object = bless {"name" => $name, "cards" => \@card_person }, $class;
    return $object;
}
#suppose the parameter is a list of card reference to be put on the bottom of the deck
sub getCards {
    my $self = shift @_;
    my $card_to_take = shift @_;

    #foreach(@{$card_to_take}) {
    #    push @{$self->{"cards"}}, $_;
    #}

    push @{$self->{"cards"}}, (@{$card_to_take});
}

#take card from the top of the deck(1st list) and put it into the game
sub dealCards {
#top of the list should be $self->{"cards"}->[0]
    my $self = shift @_;
    my $card_to_deal = $self->{"cards"}->[0];
    #shift to pop the first element
    shift $self->{"cards"};

    return $card_to_deal;

}
#returning the current number of card
sub numCards {
    my $self = shift @_;
    return scalar(@{$self->{"cards"}});
}

#this subRoutine
sub findCardToReturn {  
    my $self = shift @_;
    my $card_stack = shift @_;
    my $numCard = scalar(@{$card_stack});

    for (my $i = 0 ; $i < $numCard ; $i++) {
            if($card_stack ->[$i] eq "J") {
                if ( $i!=0) {

                    my @to_return = splice @{$card_stack};
                    @to_return = reverse(@{to_return});
                    $self->getCards(\@to_return);
                    return 1;
                }
            }
        for (my $j = $i+1 ; $j<$numCard; $j++) {
            if( $card_stack->[$i] eq $card_stack->[$j]) {

                my @to_return = splice @{$card_stack}, $i, ($j-$i+1);
                 @to_return = reverse(@to_return);
                $self->getCards(\@to_return);
                return 1;
            }

        }   
    }


}


return 1;