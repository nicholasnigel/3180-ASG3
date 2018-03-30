use strict;
use warnings;

sub printing {

    my $list = shift \@_;
        
    print $list->[1]. "\n";
    
    my $n = scalar(@{$list});
    print $n. "\n";
    

}

printing (['james','jacqualine','jean']);