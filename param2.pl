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

printing (['james','jacqualine','jean']);