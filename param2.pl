use strict;
use warnings;

sub printing {

    my $list = shift \@_;
        
    print $list->[0]. "\n";
    
    my $n = scalar(@{$list});
    print $n. "\n";
    
    #shift $list;
    foreach (@{$list}){
        print $_. "\n";
    }

    #print $list->[0]. "\n";

}

sub printing2 {
    my $list =  \@_;
    my $list_num = scalar(@{$list});

    my $i = 0;
    while( $i < $list_num) {
        print $list->[$i]. " ";
        $i++;
    }
    
}

#printing (['james','jacqualine','jean']);
my @names = ("jon", "lambert");
printing2(@names);